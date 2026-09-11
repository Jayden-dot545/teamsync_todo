import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import '../generated/protocol.dart';
import '../services/email_service.dart';

class TodoListEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Retrieves all TodoLists the current user is a member of or owns.
  Future<List<TodoList>> getLists(Session session) async {
    final authUserId = session.authenticated!.authUserId;
    String? userEmail;
    String? userName;
    try {
      final userProfile = await session.authenticated!.userProfile(session);
      userEmail = userProfile?.email?.trim().toLowerCase();
      userName = userProfile?.userName ?? userProfile?.fullName;
    } catch (_) {}

    // 1. Auto-claim / Link any pending email invitations to this authUserId
    if (userEmail != null && userEmail.isNotEmpty) {
      try {
        final unlinkedMembers = await TodoListMember.db.find(
          session,
          where: (t) => t.userEmail.equals(userEmail) & t.userId.equals(null),
        );
        for (final member in unlinkedMembers) {
          member.userId = authUserId;
          if (userName != null) {
            member.userName = userName;
          }
          await TodoListMember.db.updateRow(session, member);
        }
      } catch (_) {}
    }

    // 2. Find all memberships by userId
    final memberships = await TodoListMember.db.find(
      session,
      where: (t) => t.userId.equals(authUserId),
    );

    final listIds = memberships.map((m) => m.todoListId).toSet();

    // 3. Find all lists owned by user or where user is a member
    final lists = await TodoList.db.find(
      session,
      where: (t) => t.ownerId.equals(authUserId) | t.id.inSet(listIds),
      orderByList: (t) => [t.createdAt.desc()],
    );

    return lists;
  }

  /// Sets and persists the user's display name on the server and across all list memberships.
  Future<String> setDisplayName(Session session, String name) async {
    final cleanName = name.trim();
    if (cleanName.isEmpty) return '';

    final authUserId = session.authenticated!.authUserId;
    final now = DateTime.now();

    // 1. Update/Upsert UserAccountProfile
    var profileData = await UserAccountProfile.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(authUserId),
    );

    if (profileData != null) {
      profileData.displayName = cleanName;
      profileData.updatedAt = now;
      await UserAccountProfile.db.updateRow(session, profileData);
    } else {
      profileData = UserAccountProfile(
        userId: authUserId,
        displayName: cleanName,
        updatedAt: now,
      );
      await UserAccountProfile.db.insertRow(session, profileData);
    }

    // 2. Update all TodoListMember rows for this user
    final memberships = await TodoListMember.db.find(
      session,
      where: (t) => t.userId.equals(authUserId),
    );

    for (final m in memberships) {
      m.userName = cleanName;
      await TodoListMember.db.updateRow(session, m);
    }

    return cleanName;
  }

  /// Retrieves the persisted display name of the current user.
  Future<String?> getDisplayName(Session session) async {
    final authUserId = session.authenticated!.authUserId;

    // 1. Try UserAccountProfile
    final profileData = await UserAccountProfile.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(authUserId),
    );
    if (profileData?.displayName != null &&
        profileData!.displayName!.trim().isNotEmpty) {
      return profileData.displayName!.trim();
    }

    // 2. Try Serverpod UserProfile
    try {
      final userProfile = await session.authenticated!.userProfile(session);
      if (userProfile?.userName != null &&
          userProfile!.userName!.trim().isNotEmpty) {
        return userProfile.userName!.trim();
      }
      if (userProfile?.fullName != null &&
          userProfile!.fullName!.trim().isNotEmpty) {
        return userProfile.fullName!.trim();
      }
    } catch (_) {}

    // 3. Try latest TodoListMember row
    final member = await TodoListMember.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(authUserId),
      orderBy: (t) => t.joinedAt.desc(),
    );

    return member?.userName;
  }

  /// Creates a new TodoList and adds the creator as the 'owner' (Chef).
  Future<TodoList> createList(
    Session session, {
    required String title,
    String? description,
    required int color,
  }) async {
    final authUserId = session.authenticated!.authUserId;
    String userName = 'User';
    String? userEmail;
    try {
      final userProfile = await session.authenticated!.userProfile(session);
      userName = userProfile?.userName ?? userProfile?.fullName ?? 'User';
      userEmail = userProfile?.email;
    } catch (_) {}

    final now = DateTime.now();
    final inviteCode = 'TS-${Uuid().v4().substring(0, 8).toUpperCase()}';
    final todoList = TodoList(
      title: title.trim(),
      description: description?.trim(),
      color: color,
      ownerId: authUserId,
      inviteCode: inviteCode,
      createdAt: now,
      updatedAt: now,
    );

    final insertedList = await TodoList.db.insertRow(session, todoList);

    final member = TodoListMember(
      todoListId: insertedList.id!,
      userId: authUserId,
      userEmail: userEmail,
      userName: userName,
      role: MemberRole.owner,
      joinedAt: now,
    );
    await TodoListMember.db.insertRow(session, member);

    return insertedList;
  }

  /// Updates list details (title, description, color).
  Future<TodoList> updateList(
    Session session, {
    required int listId,
    required String title,
    String? description,
    required int color,
  }) async {
    final membership = await _getMembership(session, listId);
    if (membership == null || membership.role == MemberRole.viewer) {
      throw TodoListException(
        message: 'Unauthorized to edit this list',
        statusCode: 403,
      );
    }

    final list = await TodoList.db.findById(session, listId);
    if (list == null) {
      throw TodoListException(
        message: 'List not found',
        statusCode: 404,
      );
    }

    final now = DateTime.now();
    list.title = title.trim();
    list.description = description?.trim();
    list.color = color;
    list.updatedAt = now;

    final updated = await TodoList.db.updateRow(session, list);

    final userProfile = await session.authenticated!.userProfile(session);
    final actorName = userProfile?.userName ?? userProfile?.fullName ?? 'User';

    await session.messages.postMessage(
      'todo_list_$listId',
      TodoListEvent(
        todoListId: listId,
        eventType: TodoEventType.listUpdated,
        actorName: actorName,
        timestamp: now,
      ),
    );

    return updated;
  }

  /// Deletes a TodoList. Only the owner can delete the list.
  Future<bool> deleteList(Session session, int listId) async {
    final membership = await _getMembership(session, listId);
    if (membership == null || membership.role != MemberRole.owner) {
      throw TodoListException(
        message: 'Only the owner can delete this list',
        statusCode: 403,
      );
    }

    final list = await TodoList.db.findById(session, listId);
    if (list == null) return false;

    await TodoList.db.deleteRow(session, list);

    await session.messages.postMessage(
      'todo_list_$listId',
      TodoListEvent(
        todoListId: listId,
        eventType: TodoEventType.listDeleted,
        timestamp: DateTime.now(),
      ),
    );

    return true;
  }

  /// Returns all members of a TodoList.
  Future<List<TodoListMember>> getMembers(Session session, int listId) async {
    final membership = await _getMembership(session, listId);
    if (membership == null) {
      throw TodoListException(
        message: 'Unauthorized',
        statusCode: 403,
      );
    }

    return await TodoListMember.db.find(
      session,
      where: (t) => t.todoListId.equals(listId),
      orderBy: (t) => t.joinedAt.asc(),
    );
  }

  /// Invites a user by email to collaborate on the list (works even if user is not yet registered!).
  Future<TodoListMember> inviteMember(
    Session session, {
    required int listId,
    required String email,
    required MemberRole role,
  }) async {
    final membership = await _getMembership(session, listId);
    if (membership == null || membership.role != MemberRole.owner) {
      throw TodoListException(
        message: 'Only the owner can invite new members',
        statusCode: 403,
      );
    }

    final cleanEmail = email.trim().toLowerCase();

    // 1. Check if user is already registered
    final profiles = await AuthServices.instance.userProfiles.admin
        .listUserProfiles(session, email: cleanEmail, limit: 1);
    final targetProfile = profiles.firstOrNull;

    // 2. Check if a member row for this email or userId already exists
    TodoListMember? existing;
    if (targetProfile != null) {
      existing = await TodoListMember.db.findFirstRow(
        session,
        where: (t) =>
            t.todoListId.equals(listId) &
            (t.userId.equals(targetProfile.authUserId) |
                t.userEmail.equals(cleanEmail)),
      );
    } else {
      existing = await TodoListMember.db.findFirstRow(
        session,
        where: (t) =>
            t.todoListId.equals(listId) & t.userEmail.equals(cleanEmail),
      );
    }

    if (existing != null) {
      existing.role = role;
      if (targetProfile != null) {
        existing.userId = targetProfile.authUserId;
        existing.userName =
            targetProfile.userName ?? targetProfile.fullName ?? cleanEmail;
      }
      final updated = await TodoListMember.db.updateRow(session, existing);
      return updated;
    }

    // 3. Insert new membership
    final newMember = TodoListMember(
      todoListId: listId,
      userId: targetProfile?.authUserId,
      userEmail: cleanEmail,
      userName:
          targetProfile?.userName ??
          targetProfile?.fullName ??
          cleanEmail.split('@').first,
      role: role,
      joinedAt: DateTime.now(),
    );

    final inserted = await TodoListMember.db.insertRow(session, newMember);

    final currentProfile = await session.authenticated!.userProfile(session);
    final actorName =
        currentProfile?.userName ?? currentProfile?.fullName ?? 'User';

    await session.messages.postMessage(
      'todo_list_$listId',
      TodoListEvent(
        todoListId: listId,
        eventType: TodoEventType.memberJoined,
        member: inserted,
        actorName: actorName,
        timestamp: DateTime.now(),
      ),
    );

    // Send ToDosync invitation email to recipient
    try {
      final list = await TodoList.db.findById(session, listId);
      if (list != null) {
        await EmailService.sendListInvitation(
          session,
          toEmail: cleanEmail,
          listTitle: list.title,
          inviterName: actorName,
          inviteCode: list.inviteCode ?? 'TS-$listId',
        );
      }
    } catch (_) {}

    return inserted;
  }

  /// Generates or retrieves the shareable invite code for a TodoList.
  Future<String> getOrCreateInviteCode(Session session, int listId) async {
    final membership = await _getMembership(session, listId);
    if (membership == null || membership.role != MemberRole.owner) {
      throw TodoListException(
        message: 'Only the owner can generate or view the invite code',
        statusCode: 403,
      );
    }

    final list = await TodoList.db.findById(session, listId);
    if (list == null) {
      throw TodoListException(
        message: 'List not found',
        statusCode: 404,
      );
    }

    if (list.inviteCode != null && list.inviteCode!.isNotEmpty) {
      return list.inviteCode!;
    }

    final code = 'TS-${Uuid().v4().substring(0, 8).toUpperCase()}';
    list.inviteCode = code;
    list.updatedAt = DateTime.now();
    await TodoList.db.updateRow(session, list);
    return code;
  }

  /// Joins a TodoList using an invite code or invite link.
  Future<TodoList> joinListByInviteCode(
    Session session,
    String codeOrLink,
  ) async {
    final authUserId = session.authenticated!.authUserId;
    final cleanCode = codeOrLink
        .trim()
        .replaceAll('https://teamsync.app/join/', '')
        .replaceAll('teamsync://join?code=', '')
        .replaceAll('teamsync.app/join/', '')
        .trim()
        .toUpperCase();

    if (cleanCode.isEmpty) {
      throw TodoListException(
        message: 'Ungültiger Einladungscode',
        statusCode: 400,
      );
    }

    final list = await TodoList.db.findFirstRow(
      session,
      where: (t) => t.inviteCode.equals(cleanCode),
    );

    if (list == null) {
      throw TodoListException(
        message: 'Keine Liste mit diesem Einladungscode gefunden',
        statusCode: 404,
      );
    }

    // 1. Check if user is already a member
    final existing = await TodoListMember.db.findFirstRow(
      session,
      where: (t) => t.todoListId.equals(list.id!) & t.userId.equals(authUserId),
    );

    if (existing != null) {
      return list; // Already a member
    }

    // 2. Fetch user profile data
    String userName = 'User';
    String? userEmail;
    try {
      final userProfile = await session.authenticated!.userProfile(session);
      userName = userProfile?.userName ?? userProfile?.fullName ?? 'User';
      userEmail = userProfile?.email;
    } catch (_) {}

    final profileData = await UserAccountProfile.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(authUserId),
    );
    if (profileData?.displayName != null &&
        profileData!.displayName!.trim().isNotEmpty) {
      userName = profileData.displayName!.trim();
    }

    final now = DateTime.now();
    final member = TodoListMember(
      todoListId: list.id!,
      userId: authUserId,
      userEmail: userEmail,
      userName: userName,
      userBio: profileData?.bio,
      userAvatar: profileData?.avatarEmoji,
      userStatus: profileData?.status,
      role: MemberRole.editor,
      joinedAt: now,
    );

    final inserted = await TodoListMember.db.insertRow(session, member);

    try {
      final activity = TodoActivity(
        todoListId: list.id!,
        actorUserId: authUserId,
        actorName: userName,
        actionType: 'joined',
        details: '$userName ist der Liste beigetreten',
        timestamp: now,
      );
      await TodoActivity.db.insertRow(session, activity);
    } catch (_) {}

    await session.messages.postMessage(
      'todo_list_${list.id}',
      TodoListEvent(
        todoListId: list.id!,
        eventType: TodoEventType.memberJoined,
        member: inserted,
        actorName: userName,
        timestamp: now,
      ),
    );

    return list;
  }

  /// Removes a member from the list or leaves the list.
  Future<bool> removeMember(
    Session session, {
    required int listId,
    UuidValue? memberUserId,
    int? memberId,
  }) async {
    final currentUserId = session.authenticated!.authUserId;
    final currentMembership = await _getMembership(session, listId);
    if (currentMembership == null) {
      throw TodoListException(
        message: 'Unauthorized',
        statusCode: 403,
      );
    }

    final targetMember = memberId != null
        ? await TodoListMember.db.findById(session, memberId)
        : memberUserId != null
        ? await TodoListMember.db.findFirstRow(
            session,
            where: (t) =>
                t.todoListId.equals(listId) & t.userId.equals(memberUserId),
          )
        : null;

    if (targetMember == null) return false;

    final isSelf = targetMember.userId == currentUserId;
    final isOwner = currentMembership.role == MemberRole.owner;

    if (!isSelf && !isOwner) {
      throw TodoListException(
        message:
            'Only the list owner or the user themselves can remove membership',
        statusCode: 403,
      );
    }

    if (targetMember.role == MemberRole.owner && isSelf) {
      throw TodoListException(
        message: 'Owner cannot leave the list. Delete the list instead.',
        statusCode: 400,
      );
    }

    await TodoListMember.db.deleteRow(session, targetMember);

    await session.messages.postMessage(
      'todo_list_$listId',
      TodoListEvent(
        todoListId: listId,
        eventType: TodoEventType.memberRemoved,
        member: targetMember,
        timestamp: DateTime.now(),
      ),
    );

    return true;
  }

  /// Sends a chat message in the list discussion (supports public and private direct messages).
  Future<TodoChatMessage> sendChatMessage(
    Session session, {
    required int listId,
    required String message,
    UuidValue? recipientUserId,
    String? recipientName,
    bool? isPrivate,
  }) async {
    final cleanMsg = message.trim();
    if (cleanMsg.isEmpty) {
      throw TodoListException(
        message: 'Message cannot be empty',
        statusCode: 400,
      );
    }

    final membership = await _getMembership(session, listId);
    if (membership == null) {
      throw TodoListException(
        message: 'Unauthorized',
        statusCode: 403,
      );
    }

    // Role check: Only Owner (Chef) and Editor (Arbeiter) can send messages
    if (membership.role == MemberRole.viewer) {
      throw TodoListException(
        message: 'Zuschauer haben nur Leserechte im Chat',
        statusCode: 403,
      );
    }

    final currentUserId = session.authenticated!.authUserId;
    final now = DateTime.now();

    final chatMsg = TodoChatMessage(
      todoListId: listId,
      senderUserId: currentUserId,
      senderName: membership.userName ?? 'Mitglied',
      senderRole: membership.role,
      recipientUserId: recipientUserId,
      recipientName: recipientName,
      isPrivate: isPrivate ?? false,
      message: cleanMsg,
      sentAt: now,
    );

    final inserted = await TodoChatMessage.db.insertRow(session, chatMsg);

    await session.messages.postMessage(
      'todo_list_$listId',
      TodoListEvent(
        todoListId: listId,
        eventType: TodoEventType.chatMessageSent,
        chatMessage: inserted,
        actorName: membership.userName,
        timestamp: now,
      ),
    );

    return inserted;
  }

  /// Retrieves chat messages of the list (public messages + user's private DMs).
  Future<List<TodoChatMessage>> getChatMessages(
    Session session,
    int listId, {
    int limit = 100,
  }) async {
    final membership = await _getMembership(session, listId);
    if (membership == null) {
      throw TodoListException(
        message: 'Unauthorized',
        statusCode: 403,
      );
    }

    final currentUserId = session.authenticated!.authUserId;

    return await TodoChatMessage.db.find(
      session,
      where: (t) =>
          t.todoListId.equals(listId) &
          (t.isPrivate.notEquals(true) |
              t.senderUserId.equals(currentUserId) |
              t.recipientUserId.equals(currentUserId)),
      orderBy: (t) => t.sentAt,
      limit: limit,
    );
  }

  /// Retrieves the persisted user account profile and app settings.
  Future<UserAccountProfile> getUserProfileData(Session session) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw TodoListException(
        message: 'Unauthenticated',
        statusCode: 401,
      );
    }

    String? userEmail;
    String? fallbackName;
    try {
      final userProfile = await session.authenticated!.userProfile(session);
      userEmail = userProfile?.email?.trim();
      fallbackName = userProfile?.userName ?? userProfile?.fullName;
    } catch (_) {}

    var profileData = await UserAccountProfile.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(authUserId),
    );

    final now = DateTime.now();

    // If no row exists yet, attempt to bootstrap with display name from Serverpod UserProfile
    if (profileData == null) {
      profileData = UserAccountProfile(
        userId: authUserId,
        email: userEmail,
        displayName: fallbackName,
        bio: 'Produktivität & Team-Sync im Fokus 🚀',
        avatarIndex: 0,
        avatarEmoji: '👑',
        status: '👑 Chef & Teamleiter',
        themeMode: 'system',
        notificationsEnabled: true,
        updatedAt: now,
      );
      profileData = await UserAccountProfile.db.insertRow(session, profileData);
    } else if (userEmail != null && profileData.email != userEmail) {
      profileData.email = userEmail;
      profileData.updatedAt = now;
      profileData = await UserAccountProfile.db.updateRow(session, profileData);
    }

    return profileData;
  }

  /// Returns the authenticated user's registered email address.
  Future<String?> getCurrentUserEmail(Session session) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return null;
    try {
      final userProfile = await session.authenticated!.userProfile(session);
      return userProfile?.email?.trim();
    } catch (_) {
      return null;
    }
  }

  /// Saves full profile and app settings to the database and syncs across list memberships.
  Future<UserAccountProfile> saveUserProfileData(
    Session session, {
    String? displayName,
    String? bio,
    int? avatarIndex,
    String? avatarEmoji,
    String? status,
    String? themeMode,
    bool? notificationsEnabled,
    String? locale,
  }) async {
    final authUserId = session.authenticated!.authUserId;
    final now = DateTime.now();

    var profileData = await UserAccountProfile.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(authUserId),
    );

    String? userEmail;
    try {
      final userProfile = await session.authenticated!.userProfile(session);
      userEmail = userProfile?.email?.trim();
    } catch (_) {}

    if (profileData != null) {
      if (userEmail != null && userEmail.isNotEmpty) {
        profileData.email = userEmail;
      }
      if (displayName != null) profileData.displayName = displayName.trim();
      if (bio != null) profileData.bio = bio.trim();
      if (avatarIndex != null) profileData.avatarIndex = avatarIndex;
      if (avatarEmoji != null) profileData.avatarEmoji = avatarEmoji;
      if (status != null) profileData.status = status;
      if (themeMode != null) profileData.themeMode = themeMode;
      if (notificationsEnabled != null) {
        profileData.notificationsEnabled = notificationsEnabled;
      }
      if (locale != null) profileData.locale = locale;
      profileData.updatedAt = now;
      profileData = await UserAccountProfile.db.updateRow(session, profileData);
    } else {
      profileData = UserAccountProfile(
        userId: authUserId,
        email: userEmail,
        displayName: displayName?.trim(),
        bio: bio?.trim() ?? 'Produktivität & Team-Sync im Fokus 🚀',
        avatarIndex: avatarIndex ?? 0,
        avatarEmoji: avatarEmoji ?? '👑',
        status: status ?? '👑 Chef & Teamleiter',
        themeMode: themeMode ?? 'dark',
        notificationsEnabled: notificationsEnabled ?? true,
        locale: locale,
        updatedAt: now,
      );
      profileData = await UserAccountProfile.db.insertRow(session, profileData);
    }

    // Sync to all TodoListMember records for this user
    final cleanName = displayName?.trim();
    final memberRows = await TodoListMember.db.find(
      session,
      where: (t) => t.userId.equals(authUserId),
    );

    for (final member in memberRows) {
      if (cleanName != null && cleanName.isNotEmpty) {
        member.userName = cleanName;
      }
      if (bio != null) member.userBio = bio.trim();
      if (avatarEmoji != null) member.userAvatar = avatarEmoji;
      if (status != null) member.userStatus = status;
      await TodoListMember.db.updateRow(session, member);
    }

    return profileData;
  }

  /// Synchronizes the user's name, bio, avatar, and status across their list memberships.
  Future<bool> updateUserProfileInfo(
    Session session, {
    required String displayName,
    String? bio,
    String? avatarEmoji,
    String? status,
  }) async {
    await saveUserProfileData(
      session,
      displayName: displayName,
      bio: bio,
      avatarEmoji: avatarEmoji,
      status: status,
    );
    return true;
  }

  /// Retrieves full profile information for a specific member in a list.
  Future<TodoListMember?> getMemberProfile(
    Session session, {
    required int listId,
    required UuidValue memberUserId,
  }) async {
    final membership = await _getMembership(session, listId);
    if (membership == null) {
      throw TodoListException(
        message: 'Unauthorized',
        statusCode: 403,
      );
    }

    return await TodoListMember.db.findFirstRow(
      session,
      where: (t) => t.todoListId.equals(listId) & t.userId.equals(memberUserId),
    );
  }

  /// Realtime stream of events for a specific TodoList.
  Stream<TodoListEvent> watchList(Session session, int listId) async* {
    final membership = await _getMembership(session, listId);
    if (membership == null) {
      throw TodoListException(
        message: 'Unauthorized',
        statusCode: 403,
      );
    }

    final stream = session.messages.createStream<TodoListEvent>(
      'todo_list_$listId',
    );

    await for (final event in stream) {
      yield event;
    }
  }

  Future<TodoListMember?> _getMembership(Session session, int listId) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return null;

    return await TodoListMember.db.findFirstRow(
      session,
      where: (t) => t.todoListId.equals(listId) & t.userId.equals(authUserId),
    );
  }
}
