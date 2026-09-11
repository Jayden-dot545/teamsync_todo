import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import '../generated/protocol.dart';

/// Endpoint for managing persistent TodoNotes within a TodoList.
class TodoNoteEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Retrieves all notes for a given TodoList, ordered by pinned first, then newest updated/created.
  Future<List<TodoNote>> getNotes(
    Session session, {
    required int listId,
  }) async {
    final membership = await _getMembership(session, listId);
    if (membership == null) {
      throw TodoListException(
        message: 'Unauthorized access to notes in this list',
        statusCode: 403,
      );
    }

    return await TodoNote.db.find(
      session,
      where: (t) => t.todoListId.equals(listId),
      orderByList: (t) => [
        t.isPinned.desc(),
        t.updatedAt.desc(),
        t.createdAt.desc(),
      ],
    );
  }

  /// Creates a new persistent TodoNote.
  Future<TodoNote> createNote(
    Session session, {
    required int listId,
    required String title,
    required String content,
    int? color,
    bool isPinned = false,
  }) async {
    final membership = await _getMembership(session, listId);
    if (membership == null || membership.role == MemberRole.viewer) {
      throw TodoListException(
        message: 'Zuschauer können keine Notizen erstellen',
        statusCode: 403,
      );
    }

    final authUserId = session.authenticated!.authUserId;
    final actorName = await _getActorName(session, listId: listId);
    final now = DateTime.now();

    final note = TodoNote(
      todoListId: listId,
      title: title.trim(),
      content: content.trim(),
      createdById: authUserId,
      createdByName: actorName,
      color: color,
      isPinned: isPinned,
      createdAt: now,
      updatedAt: now,
    );

    final inserted = await TodoNote.db.insertRow(session, note);

    // Broadcast real-time update event
    await session.messages.postMessage(
      'todo_list_$listId',
      TodoListEvent(
        todoListId: listId,
        eventType: TodoEventType.noteCreated,
        note: inserted,
        actorName: actorName,
        timestamp: now,
      ),
    );

    return inserted;
  }

  /// Updates an existing TodoNote.
  Future<TodoNote> updateNote(
    Session session, {
    required int noteId,
    required String title,
    required String content,
    int? color,
    bool? isPinned,
  }) async {
    final note = await TodoNote.db.findById(session, noteId);
    if (note == null) {
      throw TodoListException(
        message: 'Notiz nicht gefunden',
        statusCode: 404,
      );
    }

    final membership = await _getMembership(session, note.todoListId);
    if (membership == null || membership.role == MemberRole.viewer) {
      throw TodoListException(
        message: 'Zuschauer können keine Notizen bearbeiten',
        statusCode: 403,
      );
    }

    final actorName = await _getActorName(session, listId: note.todoListId);
    final now = DateTime.now();

    note.title = title.trim();
    note.content = content.trim();
    if (color != null) note.color = color;
    if (isPinned != null) note.isPinned = isPinned;
    note.updatedAt = now;

    final updated = await TodoNote.db.updateRow(session, note);

    await session.messages.postMessage(
      'todo_list_${note.todoListId}',
      TodoListEvent(
        todoListId: note.todoListId,
        eventType: TodoEventType.noteUpdated,
        note: updated,
        actorName: actorName,
        timestamp: now,
      ),
    );

    return updated;
  }

  /// Toggles the pinned status of a TodoNote.
  Future<TodoNote> togglePin(
    Session session, {
    required int noteId,
  }) async {
    final note = await TodoNote.db.findById(session, noteId);
    if (note == null) {
      throw TodoListException(
        message: 'Notiz nicht gefunden',
        statusCode: 404,
      );
    }

    final membership = await _getMembership(session, note.todoListId);
    if (membership == null || membership.role == MemberRole.viewer) {
      throw TodoListException(
        message: 'Zuschauer haben nur Leserechte',
        statusCode: 403,
      );
    }

    final actorName = await _getActorName(session, listId: note.todoListId);
    final now = DateTime.now();

    note.isPinned = !note.isPinned;
    note.updatedAt = now;

    final updated = await TodoNote.db.updateRow(session, note);

    await session.messages.postMessage(
      'todo_list_${note.todoListId}',
      TodoListEvent(
        todoListId: note.todoListId,
        eventType: TodoEventType.noteUpdated,
        note: updated,
        actorName: actorName,
        timestamp: now,
      ),
    );

    return updated;
  }

  /// Deletes a TodoNote from the database.
  Future<bool> deleteNote(
    Session session, {
    required int noteId,
  }) async {
    final note = await TodoNote.db.findById(session, noteId);
    if (note == null) return false;

    final membership = await _getMembership(session, note.todoListId);
    if (membership == null || membership.role == MemberRole.viewer) {
      throw TodoListException(
        message: 'Zuschauer können keine Notizen löschen',
        statusCode: 403,
      );
    }

    final actorName = await _getActorName(session, listId: note.todoListId);
    final listId = note.todoListId;

    await TodoNote.db.deleteRow(session, note);

    await session.messages.postMessage(
      'todo_list_$listId',
      TodoListEvent(
        todoListId: listId,
        eventType: TodoEventType.noteDeleted,
        noteId: noteId,
        actorName: actorName,
        timestamp: DateTime.now(),
      ),
    );

    return true;
  }

  Future<TodoListMember?> _getMembership(Session session, int listId) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return null;

    return await TodoListMember.db.findFirstRow(
      session,
      where: (t) => t.todoListId.equals(listId) & t.userId.equals(authUserId),
    );
  }

  Future<String> _getActorName(Session session, {required int listId}) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return 'Unbekannt';

    final member = await _getMembership(session, listId);
    if (member?.userName != null && member!.userName!.trim().isNotEmpty) {
      return member.userName!.trim();
    }

    final profile = await UserAccountProfile.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(authUserId),
    );
    if (profile?.displayName != null && profile!.displayName!.trim().isNotEmpty) {
      return profile.displayName!.trim();
    }

    try {
      final userProfile = await session.authenticated!.userProfile(session);
      return userProfile?.userName ?? userProfile?.fullName ?? 'Mitarbeiter';
    } catch (_) {
      return 'Mitarbeiter';
    }
  }
}
