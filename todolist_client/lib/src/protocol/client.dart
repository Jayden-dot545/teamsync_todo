/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _ida;
import 'package:http/http.dart' as _i85jenna;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:todolist_client/src/protocol/greetings/greeting.dart'
    as _ine3t3dy;
import 'package:todolist_client/src/protocol/todos/member_role.dart'
    as _ixph1ikv;
import 'package:todolist_client/src/protocol/todos/todo_activity.dart'
    as _i996je9u;
import 'package:todolist_client/src/protocol/todos/todo_chat_message.dart'
    as _igy2qi0p;
import 'package:todolist_client/src/protocol/todos/todo_item.dart' as _iy7cwfj6;
import 'package:todolist_client/src/protocol/todos/todo_list.dart' as _ic5wdmhp;
import 'package:todolist_client/src/protocol/todos/todo_list_event.dart'
    as _ir56vhs7;
import 'package:todolist_client/src/protocol/todos/todo_list_member.dart'
    as _i8r85dx0;
import 'package:todolist_client/src/protocol/todos/todo_note.dart' as _iwyd7ghh;
import 'package:todolist_client/src/protocol/todos/todo_priority.dart'
    as _ik6od871;
import 'package:todolist_client/src/protocol/todos/user_account_profile.dart'
    as _ib29orij;
import 'protocol.dart' as _il2as5qe;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _isc.EndpointRef {
  EndpointGreeting(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _ida.Future<_ine3t3dy.Greeting> hello(String name) =>
      caller.callServerEndpoint<_ine3t3dy.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

/// Endpoint for managing TodoItems within a TodoList.
/// {@category Endpoint}
class EndpointTodoItem extends _isc.EndpointRef {
  EndpointTodoItem(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'todoItem';

  /// Retrieves all items for a given TodoList.
  _ida.Future<List<_iy7cwfj6.TodoItem>> getItems({required int listId}) =>
      caller.callServerEndpoint<List<_iy7cwfj6.TodoItem>>(
        'todoItem',
        'getItems',
        {'listId': listId},
      );

  /// Creates a new TodoItem.
  _ida.Future<_iy7cwfj6.TodoItem> createItem({
    required int listId,
    required String title,
    String? description,
    DateTime? dueDate,
    required _ik6od871.TodoPriority priority,
    _isc.UuidValue? assignedToUserId,
    String? assignedToName,
    String? subtasksJson,
    String? workSessionsJson,
    String? recurrence,
  }) => caller.callServerEndpoint<_iy7cwfj6.TodoItem>(
    'todoItem',
    'createItem',
    {
      'listId': listId,
      'title': title,
      'description': description,
      'dueDate': dueDate,
      'priority': priority,
      'assignedToUserId': assignedToUserId,
      'assignedToName': assignedToName,
      'subtasksJson': subtasksJson,
      'workSessionsJson': workSessionsJson,
      'recurrence': recurrence,
    },
  );

  /// Updates an existing TodoItem.
  _ida.Future<_iy7cwfj6.TodoItem> updateItem({
    required int itemId,
    required String title,
    String? description,
    DateTime? dueDate,
    required _ik6od871.TodoPriority priority,
    _isc.UuidValue? assignedToUserId,
    String? assignedToName,
    String? subtasksJson,
    String? workSessionsJson,
    String? recurrence,
  }) => caller.callServerEndpoint<_iy7cwfj6.TodoItem>(
    'todoItem',
    'updateItem',
    {
      'itemId': itemId,
      'title': title,
      'description': description,
      'dueDate': dueDate,
      'priority': priority,
      'assignedToUserId': assignedToUserId,
      'assignedToName': assignedToName,
      'subtasksJson': subtasksJson,
      'workSessionsJson': workSessionsJson,
      'recurrence': recurrence,
    },
  );

  /// Toggles a subtask inside a TodoItem.
  _ida.Future<_iy7cwfj6.TodoItem> toggleSubtask({
    required int itemId,
    required String subtaskId,
  }) => caller.callServerEndpoint<_iy7cwfj6.TodoItem>(
    'todoItem',
    'toggleSubtask',
    {
      'itemId': itemId,
      'subtaskId': subtaskId,
    },
  );

  /// Toggles the completion status of a TodoItem.
  _ida.Future<_iy7cwfj6.TodoItem> toggleComplete({required int itemId}) =>
      caller.callServerEndpoint<_iy7cwfj6.TodoItem>(
        'todoItem',
        'toggleComplete',
        {'itemId': itemId},
      );

  /// Starts live work time tracking for a task.
  _ida.Future<_iy7cwfj6.TodoItem> startTimer({required int itemId}) =>
      caller.callServerEndpoint<_iy7cwfj6.TodoItem>(
        'todoItem',
        'startTimer',
        {'itemId': itemId},
      );

  /// Pauses the work time tracking and saves interval in workSessionsJson.
  _ida.Future<_iy7cwfj6.TodoItem> pauseTimer({required int itemId}) =>
      caller.callServerEndpoint<_iy7cwfj6.TodoItem>(
        'todoItem',
        'pauseTimer',
        {'itemId': itemId},
      );

  /// Deletes a TodoItem.
  _ida.Future<bool> deleteItem({required int itemId}) =>
      caller.callServerEndpoint<bool>(
        'todoItem',
        'deleteItem',
        {'itemId': itemId},
      );

  /// Reorders items in a list.
  _ida.Future<void> reorderItems({
    required int listId,
    required List<int> itemIds,
  }) => caller.callServerEndpoint<void>(
    'todoItem',
    'reorderItems',
    {
      'listId': listId,
      'itemIds': itemIds,
    },
  );

  /// Fetches recent audit-log activities for a list.
  _ida.Future<List<_i996je9u.TodoActivity>> getActivities({
    required int listId,
    int? limit,
  }) => caller.callServerEndpoint<List<_i996je9u.TodoActivity>>(
    'todoItem',
    'getActivities',
    {
      'listId': listId,
      'limit': limit,
    },
  );
}

/// {@category Endpoint}
class EndpointTodoList extends _isc.EndpointRef {
  EndpointTodoList(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'todoList';

  /// Retrieves all TodoLists the current user is a member of or owns.
  _ida.Future<List<_ic5wdmhp.TodoList>> getLists() =>
      caller.callServerEndpoint<List<_ic5wdmhp.TodoList>>(
        'todoList',
        'getLists',
        {},
      );

  /// Sets and persists the user's display name on the server and across all list memberships.
  _ida.Future<String> setDisplayName(String name) =>
      caller.callServerEndpoint<String>(
        'todoList',
        'setDisplayName',
        {'name': name},
      );

  /// Retrieves the persisted display name of the current user.
  _ida.Future<String?> getDisplayName() => caller.callServerEndpoint<String?>(
    'todoList',
    'getDisplayName',
    {},
  );

  /// Creates a new TodoList and adds the creator as the 'owner' (Chef).
  _ida.Future<_ic5wdmhp.TodoList> createList({
    required String title,
    String? description,
    required int color,
  }) => caller.callServerEndpoint<_ic5wdmhp.TodoList>(
    'todoList',
    'createList',
    {
      'title': title,
      'description': description,
      'color': color,
    },
  );

  /// Updates list details (title, description, color).
  _ida.Future<_ic5wdmhp.TodoList> updateList({
    required int listId,
    required String title,
    String? description,
    required int color,
  }) => caller.callServerEndpoint<_ic5wdmhp.TodoList>(
    'todoList',
    'updateList',
    {
      'listId': listId,
      'title': title,
      'description': description,
      'color': color,
    },
  );

  /// Deletes a TodoList. Only the owner can delete the list.
  _ida.Future<bool> deleteList(int listId) => caller.callServerEndpoint<bool>(
    'todoList',
    'deleteList',
    {'listId': listId},
  );

  /// Returns all members of a TodoList.
  _ida.Future<List<_i8r85dx0.TodoListMember>> getMembers(int listId) =>
      caller.callServerEndpoint<List<_i8r85dx0.TodoListMember>>(
        'todoList',
        'getMembers',
        {'listId': listId},
      );

  /// Invites a user by email to collaborate on the list (works even if user is not yet registered!).
  _ida.Future<_i8r85dx0.TodoListMember> inviteMember({
    required int listId,
    required String email,
    required _ixph1ikv.MemberRole role,
  }) => caller.callServerEndpoint<_i8r85dx0.TodoListMember>(
    'todoList',
    'inviteMember',
    {
      'listId': listId,
      'email': email,
      'role': role,
    },
  );

  /// Generates or retrieves the shareable invite code for a TodoList.
  _ida.Future<String> getOrCreateInviteCode(int listId) =>
      caller.callServerEndpoint<String>(
        'todoList',
        'getOrCreateInviteCode',
        {'listId': listId},
      );

  /// Joins a TodoList using an invite code or invite link.
  _ida.Future<_ic5wdmhp.TodoList> joinListByInviteCode(String codeOrLink) =>
      caller.callServerEndpoint<_ic5wdmhp.TodoList>(
        'todoList',
        'joinListByInviteCode',
        {'codeOrLink': codeOrLink},
      );

  /// Removes a member from the list or leaves the list.
  _ida.Future<bool> removeMember({
    required int listId,
    _isc.UuidValue? memberUserId,
    int? memberId,
  }) => caller.callServerEndpoint<bool>(
    'todoList',
    'removeMember',
    {
      'listId': listId,
      'memberUserId': memberUserId,
      'memberId': memberId,
    },
  );

  /// Sends a chat message in the list discussion (supports public and private direct messages).
  _ida.Future<_igy2qi0p.TodoChatMessage> sendChatMessage({
    required int listId,
    required String message,
    _isc.UuidValue? recipientUserId,
    String? recipientName,
    bool? isPrivate,
  }) => caller.callServerEndpoint<_igy2qi0p.TodoChatMessage>(
    'todoList',
    'sendChatMessage',
    {
      'listId': listId,
      'message': message,
      'recipientUserId': recipientUserId,
      'recipientName': recipientName,
      'isPrivate': isPrivate,
    },
  );

  /// Retrieves chat messages of the list (public messages + user's private DMs).
  _ida.Future<List<_igy2qi0p.TodoChatMessage>> getChatMessages(
    int listId, {
    required int limit,
  }) => caller.callServerEndpoint<List<_igy2qi0p.TodoChatMessage>>(
    'todoList',
    'getChatMessages',
    {
      'listId': listId,
      'limit': limit,
    },
  );

  /// Retrieves the persisted user account profile and app settings.
  _ida.Future<_ib29orij.UserAccountProfile> getUserProfileData() =>
      caller.callServerEndpoint<_ib29orij.UserAccountProfile>(
        'todoList',
        'getUserProfileData',
        {},
      );

  /// Returns the authenticated user's registered email address.
  _ida.Future<String?> getCurrentUserEmail() =>
      caller.callServerEndpoint<String?>(
        'todoList',
        'getCurrentUserEmail',
        {},
      );

  /// Saves full profile and app settings to the database and syncs across list memberships.
  _ida.Future<_ib29orij.UserAccountProfile> saveUserProfileData({
    String? displayName,
    String? bio,
    int? avatarIndex,
    String? avatarEmoji,
    String? status,
    String? themeMode,
    bool? notificationsEnabled,
    String? locale,
  }) => caller.callServerEndpoint<_ib29orij.UserAccountProfile>(
    'todoList',
    'saveUserProfileData',
    {
      'displayName': displayName,
      'bio': bio,
      'avatarIndex': avatarIndex,
      'avatarEmoji': avatarEmoji,
      'status': status,
      'themeMode': themeMode,
      'notificationsEnabled': notificationsEnabled,
      'locale': locale,
    },
  );

  /// Synchronizes the user's name, bio, avatar, and status across their list memberships.
  _ida.Future<bool> updateUserProfileInfo({
    required String displayName,
    String? bio,
    String? avatarEmoji,
    String? status,
  }) => caller.callServerEndpoint<bool>(
    'todoList',
    'updateUserProfileInfo',
    {
      'displayName': displayName,
      'bio': bio,
      'avatarEmoji': avatarEmoji,
      'status': status,
    },
  );

  /// Retrieves full profile information for a specific member in a list.
  _ida.Future<_i8r85dx0.TodoListMember?> getMemberProfile({
    required int listId,
    required _isc.UuidValue memberUserId,
  }) => caller.callServerEndpoint<_i8r85dx0.TodoListMember?>(
    'todoList',
    'getMemberProfile',
    {
      'listId': listId,
      'memberUserId': memberUserId,
    },
  );

  /// Realtime stream of events for a specific TodoList.
  _ida.Stream<_ir56vhs7.TodoListEvent> watchList(int listId) =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_ir56vhs7.TodoListEvent>,
        _ir56vhs7.TodoListEvent
      >(
        'todoList',
        'watchList',
        {'listId': listId},
        {},
      );
}

/// Endpoint for managing persistent TodoNotes within a TodoList.
/// {@category Endpoint}
class EndpointTodoNote extends _isc.EndpointRef {
  EndpointTodoNote(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'todoNote';

  /// Retrieves all notes for a given TodoList, ordered by pinned first, then newest updated/created.
  _ida.Future<List<_iwyd7ghh.TodoNote>> getNotes({required int listId}) =>
      caller.callServerEndpoint<List<_iwyd7ghh.TodoNote>>(
        'todoNote',
        'getNotes',
        {'listId': listId},
      );

  /// Creates a new persistent TodoNote.
  _ida.Future<_iwyd7ghh.TodoNote> createNote({
    required int listId,
    required String title,
    required String content,
    int? color,
    required bool isPinned,
  }) => caller.callServerEndpoint<_iwyd7ghh.TodoNote>(
    'todoNote',
    'createNote',
    {
      'listId': listId,
      'title': title,
      'content': content,
      'color': color,
      'isPinned': isPinned,
    },
  );

  /// Updates an existing TodoNote.
  _ida.Future<_iwyd7ghh.TodoNote> updateNote({
    required int noteId,
    required String title,
    required String content,
    int? color,
    bool? isPinned,
  }) => caller.callServerEndpoint<_iwyd7ghh.TodoNote>(
    'todoNote',
    'updateNote',
    {
      'noteId': noteId,
      'title': title,
      'content': content,
      'color': color,
      'isPinned': isPinned,
    },
  );

  /// Toggles the pinned status of a TodoNote.
  _ida.Future<_iwyd7ghh.TodoNote> togglePin({required int noteId}) =>
      caller.callServerEndpoint<_iwyd7ghh.TodoNote>(
        'todoNote',
        'togglePin',
        {'noteId': noteId},
      );

  /// Deletes a TodoNote from the database.
  _ida.Future<bool> deleteNote({required int noteId}) =>
      caller.callServerEndpoint<bool>(
        'todoNote',
        'deleteNote',
        {'noteId': noteId},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    greeting = EndpointGreeting(this);
    todoItem = EndpointTodoItem(this);
    todoList = EndpointTodoList(this);
    todoNote = EndpointTodoNote(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointGreeting greeting;

  late final EndpointTodoItem todoItem;

  late final EndpointTodoList todoList;

  late final EndpointTodoNote todoNote;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'greeting': greeting,
    'todoItem': todoItem,
    'todoList': todoList,
    'todoNote': todoNote,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
