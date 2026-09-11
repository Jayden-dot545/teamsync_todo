import 'dart:convert';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import '../generated/protocol.dart';

/// Endpoint for managing TodoItems within a TodoList.
class TodoItemEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Retrieves all items for a given TodoList.
  Future<List<TodoItem>> getItems(
    Session session, {
    required int listId,
  }) async {
    final membership = await _getMembership(session, listId);
    if (membership == null) {
      throw TodoListException(
        message: 'Unauthorized access to this list',
        statusCode: 403,
      );
    }

    return await TodoItem.db.find(
      session,
      where: (t) => t.todoListId.equals(listId),
      orderBy: (t) => t.sortOrder.asc(),
    );
  }

  /// Creates a new TodoItem.
  Future<TodoItem> createItem(
    Session session, {
    required int listId,
    required String title,
    String? description,
    DateTime? dueDate,
    required TodoPriority priority,
    UuidValue? assignedToUserId,
    String? assignedToName,
    String? subtasksJson,
    String? workSessionsJson,
    String? recurrence,
  }) async {
    final membership = await _getMembership(session, listId);
    if (membership == null || membership.role == MemberRole.viewer) {
      throw TodoListException(
        message:
            'Zuschauer haben nur Leserechte und können keine Aufgaben erstellen',
        statusCode: 403,
      );
    }

    final authUserId = session.authenticated!.authUserId;
    final creatorName = await _getActorName(session, listId: listId);

    // Find the highest sortOrder to append to the end
    final existingItems = await TodoItem.db.find(
      session,
      where: (t) => t.todoListId.equals(listId),
      orderBy: (t) => t.sortOrder.desc(),
      limit: 1,
    );
    final nextSortOrder = existingItems.isNotEmpty
        ? existingItems.first.sortOrder + 100.0
        : 100.0;

    final now = DateTime.now();
    final item = TodoItem(
      todoListId: listId,
      title: title.trim(),
      description: description?.trim(),
      isCompleted: false,
      dueDate: dueDate,
      priority: priority,
      assignedToUserId: assignedToUserId,
      assignedToName: assignedToName,
      createdById: authUserId,
      createdByName: creatorName,
      createdAt: now,
      sortOrder: nextSortOrder,
      subtasksJson: subtasksJson,
      workSessionsJson: workSessionsJson,
      recurrence: recurrence,
    );

    final inserted = await TodoItem.db.insertRow(session, item);

    await _logActivity(
      session,
      listId: listId,
      actionType: 'created',
      details: 'Aufgabe "$title" erstellt',
      targetTitle: title,
    );

    await session.messages.postMessage(
      'todo_list_$listId',
      TodoListEvent(
        todoListId: listId,
        eventType: TodoEventType.itemCreated,
        todoItem: inserted,
        actorName: creatorName,
        timestamp: now,
      ),
    );

    return inserted;
  }

  /// Updates an existing TodoItem.
  Future<TodoItem> updateItem(
    Session session, {
    required int itemId,
    required String title,
    String? description,
    DateTime? dueDate,
    required TodoPriority priority,
    UuidValue? assignedToUserId,
    String? assignedToName,
    String? subtasksJson,
    String? workSessionsJson,
    String? recurrence,
  }) async {
    final item = await TodoItem.db.findById(session, itemId);
    if (item == null) {
      throw TodoListException(
        message: 'Item not found',
        statusCode: 404,
      );
    }

    final membership = await _getMembership(session, item.todoListId);
    if (membership == null || membership.role == MemberRole.viewer) {
      throw TodoListException(
        message: 'Unauthorized to edit tasks in this list',
        statusCode: 403,
      );
    }

    final now = DateTime.now();
    item.title = title.trim();
    item.description = description?.trim();
    item.dueDate = dueDate;
    item.priority = priority;
    item.assignedToUserId = assignedToUserId;
    item.assignedToName = assignedToName;
    item.subtasksJson = subtasksJson;
    item.recurrence = recurrence;
    if (workSessionsJson != null) {
      item.workSessionsJson = workSessionsJson;
    }
    item.updatedAt = now;

    final updated = await TodoItem.db.updateRow(session, item);
    final actorName = await _getActorName(session, listId: item.todoListId);

    await session.messages.postMessage(
      'todo_list_${item.todoListId}',
      TodoListEvent(
        todoListId: item.todoListId,
        eventType: TodoEventType.itemUpdated,
        todoItem: updated,
        actorName: actorName,
        timestamp: now,
      ),
    );

    return updated;
  }

  /// Toggles a subtask inside a TodoItem.
  Future<TodoItem> toggleSubtask(
    Session session, {
    required int itemId,
    required String subtaskId,
  }) async {
    final item = await TodoItem.db.findById(session, itemId);
    if (item == null) {
      throw TodoListException(
        message: 'Item not found',
        statusCode: 404,
      );
    }

    final membership = await _getMembership(session, item.todoListId);
    if (membership == null || membership.role == MemberRole.viewer) {
      throw TodoListException(
        message: 'Zuschauer haben nur Leserechte',
        statusCode: 403,
      );
    }

    if (item.subtasksJson != null && item.subtasksJson!.isNotEmpty) {
      try {
        final List<dynamic> list = jsonDecode(item.subtasksJson!);
        for (final st in list) {
          if (st is Map && st['id'] == subtaskId) {
            st['isDone'] = !(st['isDone'] as bool? ?? false);
            break;
          }
        }
        item.subtasksJson = jsonEncode(list);
      } catch (_) {}
    }

    final now = DateTime.now();
    item.updatedAt = now;
    final updated = await TodoItem.db.updateRow(session, item);
    final actorName = await _getActorName(session, listId: item.todoListId);

    await session.messages.postMessage(
      'todo_list_${item.todoListId}',
      TodoListEvent(
        todoListId: item.todoListId,
        eventType: TodoEventType.itemUpdated,
        todoItem: updated,
        actorName: actorName,
        timestamp: now,
      ),
    );

    return updated;
  }

  /// Toggles the completion status of a TodoItem.
  Future<TodoItem> toggleComplete(
    Session session, {
    required int itemId,
  }) async {
    final item = await TodoItem.db.findById(session, itemId);
    if (item == null) {
      throw TodoListException(
        message: 'Item not found',
        statusCode: 404,
      );
    }

    final membership = await _getMembership(session, item.todoListId);
    if (membership == null || membership.role == MemberRole.viewer) {
      throw TodoListException(
        message:
            'Zuschauer haben nur Leserechte und können Aufgaben nicht abhaken',
        statusCode: 403,
      );
    }

    final authUserId = session.authenticated!.authUserId;
    final actorName = await _getActorName(session, listId: item.todoListId);

    final now = DateTime.now();
    item.isCompleted = !item.isCompleted;
    if (item.isCompleted) {
      item.completedAt = now;
      item.completedByUserId = authUserId;
      item.completedByName = actorName;

      // If timer is running, stop and add work session log
      if (item.isTimerRunning == true && item.timerStartedAt != null) {
        _recordWorkSession(
          item: item,
          start: item.timerStartedAt!,
          end: now,
          userName: item.timerUserName ?? actorName,
          userId: item.timerUserId ?? authUserId,
        );
        item.isTimerRunning = false;
        item.timerStartedAt = null;
      }
    } else {
      item.completedAt = null;
      item.completedByUserId = null;
      item.completedByName = null;
    }
    item.updatedAt = now;

    final updated = await TodoItem.db.updateRow(session, item);

    await _logActivity(
      session,
      listId: item.todoListId,
      actionType: updated.isCompleted ? 'completed' : 'reopened',
      details: updated.isCompleted
          ? 'Aufgabe "${updated.title}" erledigt'
          : 'Aufgabe "${updated.title}" wiedereröffnet',
      targetTitle: updated.title,
    );

    await session.messages.postMessage(
      'todo_list_${item.todoListId}',
      TodoListEvent(
        todoListId: item.todoListId,
        eventType: TodoEventType.itemUpdated,
        todoItem: updated,
        actorName: actorName,
        timestamp: now,
      ),
    );

    // If recurring task completed, create next upcoming occurrence automatically
    if (updated.isCompleted &&
        updated.recurrence != null &&
        updated.recurrence!.isNotEmpty) {
      final nextDue = _calculateNextDueDate(
        updated.dueDate ?? now,
        updated.recurrence!,
      );

      final nextItem = TodoItem(
        todoListId: updated.todoListId,
        title: updated.title,
        description: updated.description,
        isCompleted: false,
        dueDate: nextDue,
        priority: updated.priority,
        assignedToUserId: updated.assignedToUserId,
        assignedToName: updated.assignedToName,
        createdById: authUserId,
        createdByName: actorName,
        createdAt: now,
        sortOrder: updated.sortOrder + 50.0,
        subtasksJson: updated.subtasksJson != null
            ? _resetSubtasks(updated.subtasksJson!)
            : null,
        recurrence: updated.recurrence,
      );

      final createdNext = await TodoItem.db.insertRow(session, nextItem);
      await session.messages.postMessage(
        'todo_list_${updated.todoListId}',
        TodoListEvent(
          todoListId: updated.todoListId,
          eventType: TodoEventType.itemCreated,
          todoItem: createdNext,
          actorName: actorName,
          timestamp: now,
        ),
      );
    }

    return updated;
  }

  /// Starts live work time tracking for a task.
  Future<TodoItem> startTimer(
    Session session, {
    required int itemId,
  }) async {
    final item = await TodoItem.db.findById(session, itemId);
    if (item == null) {
      throw TodoListException(
        message: 'Item not found',
        statusCode: 404,
      );
    }

    final membership = await _getMembership(session, item.todoListId);
    if (membership == null || membership.role == MemberRole.viewer) {
      throw TodoListException(
        message: 'Zuschauer können keine Zeiterfassung starten',
        statusCode: 403,
      );
    }

    final authUserId = session.authenticated!.authUserId;
    final actorName = await _getActorName(session, listId: item.todoListId);
    final now = DateTime.now();

    // If timer was already running, record the previous session interval
    if (item.isTimerRunning == true && item.timerStartedAt != null) {
      _recordWorkSession(
        item: item,
        start: item.timerStartedAt!,
        end: now,
        userName: item.timerUserName ?? actorName,
        userId: item.timerUserId ?? authUserId,
      );
    }

    item.isTimerRunning = true;
    item.timerStartedAt = now;
    item.timerUserId = authUserId;
    item.timerUserName = actorName;
    item.updatedAt = now;

    final updated = await TodoItem.db.updateRow(session, item);

    await session.messages.postMessage(
      'todo_list_${item.todoListId}',
      TodoListEvent(
        todoListId: item.todoListId,
        eventType: TodoEventType.itemUpdated,
        todoItem: updated,
        actorName: actorName,
        timestamp: now,
      ),
    );

    return updated;
  }

  /// Pauses the work time tracking and saves interval in workSessionsJson.
  Future<TodoItem> pauseTimer(
    Session session, {
    required int itemId,
  }) async {
    final item = await TodoItem.db.findById(session, itemId);
    if (item == null) {
      throw TodoListException(
        message: 'Item not found',
        statusCode: 404,
      );
    }

    final membership = await _getMembership(session, item.todoListId);
    if (membership == null || membership.role == MemberRole.viewer) {
      throw TodoListException(
        message: 'Unauthorized',
        statusCode: 403,
      );
    }

    final authUserId = session.authenticated!.authUserId;
    final actorName = await _getActorName(session, listId: item.todoListId);
    final now = DateTime.now();

    if (item.isTimerRunning == true && item.timerStartedAt != null) {
      _recordWorkSession(
        item: item,
        start: item.timerStartedAt!,
        end: now,
        userName: item.timerUserName ?? actorName,
        userId: item.timerUserId ?? authUserId,
      );
    }

    item.isTimerRunning = false;
    item.timerStartedAt = null;
    item.updatedAt = now;

    final updated = await TodoItem.db.updateRow(session, item);

    await _logActivity(
      session,
      listId: item.todoListId,
      actionType: 'timer',
      details: 'Zeiterfassung für "${item.title}" beendet',
      targetTitle: item.title,
    );

    await session.messages.postMessage(
      'todo_list_${item.todoListId}',
      TodoListEvent(
        todoListId: item.todoListId,
        eventType: TodoEventType.itemUpdated,
        todoItem: updated,
        actorName: actorName,
        timestamp: now,
      ),
    );

    return updated;
  }

  /// Helper to record a completed work session and update totalDurationSeconds.
  void _recordWorkSession({
    required TodoItem item,
    required DateTime start,
    required DateTime end,
    required String? userName,
    required UuidValue? userId,
  }) {
    final elapsed = end.difference(start).inSeconds;
    if (elapsed <= 0) return;

    item.totalDurationSeconds = (item.totalDurationSeconds ?? 0) + elapsed;

    List<dynamic> sessions = [];
    if (item.workSessionsJson != null &&
        item.workSessionsJson!.trim().isNotEmpty) {
      try {
        final decoded = jsonDecode(item.workSessionsJson!);
        if (decoded is List) {
          sessions = decoded;
        }
      } catch (_) {}
    }

    final newSession = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'startTime': start.toIso8601String(),
      'endTime': end.toIso8601String(),
      'durationSeconds': elapsed,
      'userName': userName,
      'userId': userId?.toString(),
    };

    sessions.add(newSession);
    item.workSessionsJson = jsonEncode(sessions);
  }

  /// Deletes a TodoItem.
  Future<bool> deleteItem(
    Session session, {
    required int itemId,
  }) async {
    final item = await TodoItem.db.findById(session, itemId);
    if (item == null) return false;

    final membership = await _getMembership(session, item.todoListId);
    if (membership == null || membership.role == MemberRole.viewer) {
      throw TodoListException(
        message: 'Unauthorized to delete tasks in this list',
        statusCode: 403,
      );
    }

    await TodoItem.db.deleteRow(session, item);
    final actorName = await _getActorName(session, listId: item.todoListId);

    await _logActivity(
      session,
      listId: item.todoListId,
      actionType: 'deleted',
      details: 'Aufgabe "${item.title}" gelöscht',
      targetTitle: item.title,
    );

    await session.messages.postMessage(
      'todo_list_${item.todoListId}',
      TodoListEvent(
        todoListId: item.todoListId,
        eventType: TodoEventType.itemDeleted,
        todoItemId: itemId,
        actorName: actorName,
        timestamp: DateTime.now(),
      ),
    );

    return true;
  }

  /// Reorders items in a list.
  Future<void> reorderItems(
    Session session, {
    required int listId,
    required List<int> itemIds,
  }) async {
    final membership = await _getMembership(session, listId);
    if (membership == null || membership.role == MemberRole.viewer) {
      throw TodoListException(
        message: 'Unauthorized',
        statusCode: 403,
      );
    }

    for (var i = 0; i < itemIds.length; i++) {
      final item = await TodoItem.db.findById(session, itemIds[i]);
      if (item != null && item.todoListId == listId) {
        item.sortOrder = (i + 1) * 100.0;
        await TodoItem.db.updateRow(session, item);
      }
    }
  }

  Future<String> _getActorName(Session session, {int? listId}) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return 'User';

    if (listId != null) {
      try {
        final member = await TodoListMember.db.findFirstRow(
          session,
          where: (t) =>
              t.todoListId.equals(listId) & t.userId.equals(authUserId),
        );
        if (member?.userName != null && member!.userName!.trim().isNotEmpty) {
          return member.userName!.trim();
        }
      } catch (_) {}
    }

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

    return 'User';
  }

  Future<TodoListMember?> _getMembership(Session session, int listId) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return null;

    return await TodoListMember.db.findFirstRow(
      session,
      where: (t) => t.todoListId.equals(listId) & t.userId.equals(authUserId),
    );
  }

  DateTime _calculateNextDueDate(DateTime baseDate, String recurrence) {
    switch (recurrence) {
      case 'daily':
        return baseDate.add(const Duration(days: 1));
      case 'workdays':
        if (baseDate.weekday == DateTime.friday) {
          return baseDate.add(const Duration(days: 3));
        } else if (baseDate.weekday == DateTime.saturday) {
          return baseDate.add(const Duration(days: 2));
        } else {
          return baseDate.add(const Duration(days: 1));
        }
      case 'weekly':
        return baseDate.add(const Duration(days: 7));
      case 'monthly':
        final nextMonth = baseDate.month == 12 ? 1 : baseDate.month + 1;
        final nextYear = baseDate.month == 12
            ? baseDate.year + 1
            : baseDate.year;
        final maxDay = DateTime(nextYear, nextMonth + 1, 0).day;
        final day = baseDate.day > maxDay ? maxDay : baseDate.day;
        return DateTime(
          nextYear,
          nextMonth,
          day,
          baseDate.hour,
          baseDate.minute,
        );
      default:
        return baseDate.add(const Duration(days: 1));
    }
  }

  String _resetSubtasks(String subtasksJson) {
    try {
      final list = jsonDecode(subtasksJson) as List<dynamic>;
      for (final item in list) {
        if (item is Map<String, dynamic>) {
          item['isDone'] = false;
        }
      }
      return jsonEncode(list);
    } catch (_) {
      return subtasksJson;
    }
  }

  /// Fetches recent audit-log activities for a list.
  Future<List<TodoActivity>> getActivities(
    Session session, {
    required int listId,
    int? limit,
  }) async {
    final membership = await _getMembership(session, listId);
    if (membership == null) {
      throw TodoListException(
        message: 'Unauthorized',
        statusCode: 403,
      );
    }

    return await TodoActivity.db.find(
      session,
      where: (t) => t.todoListId.equals(listId),
      orderBy: (t) => t.timestamp.desc(),
      limit: limit ?? 50,
    );
  }

  Future<void> _logActivity(
    Session session, {
    required int listId,
    required String actionType,
    required String details,
    String? targetTitle,
  }) async {
    try {
      final authUserId = session.authenticated?.authUserId;
      final actorName = await _getActorName(session, listId: listId);
      final now = DateTime.now();
      final activity = TodoActivity(
        todoListId: listId,
        actorUserId: authUserId,
        actorName: actorName,
        actionType: actionType,
        details: details,
        targetTitle: targetTitle,
        timestamp: now,
      );
      await TodoActivity.db.insertRow(session, activity);
    } catch (_) {}
  }
}
