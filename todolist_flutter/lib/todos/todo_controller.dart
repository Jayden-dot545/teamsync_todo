import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/client.dart';
import 'models/subtask.dart';

enum TodoFilter {
  all,
  active,
  completed,
  highPriority,
  assignedToMe,
}

class TodoController extends ChangeNotifier {
  final int listId;
  List<TodoItem> _items = [];
  List<TodoListMember> _members = [];
  List<TodoItem>? _cachedFilteredItems;
  bool _isLoading = false;
  String? _errorMessage;
  TodoFilter _currentFilter = TodoFilter.all;
  String _searchQuery = '';
  StreamSubscription<TodoListEvent>? _streamSubscription;
  final _eventController = StreamController<TodoListEvent>.broadcast();

  TodoController({required this.listId}) {
    fetchItems();
    fetchMembers();
    _startListening();
  }

  Stream<TodoListEvent> get onEvent => _eventController.stream;

  List<TodoItem> get items => _items;
  List<TodoListMember> get members => _members;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  TodoFilter get currentFilter => _currentFilter;
  String get searchQuery => _searchQuery;
  UuidValue? get currentUserId => client.auth.authInfo?.authUserId;

  MemberRole? get myRole {
    final currentUserId = client.auth.authInfo?.authUserId;
    if (currentUserId == null) return null;
    final member = _members.where((m) => m.userId == currentUserId).firstOrNull;
    return member?.role;
  }

  bool get isViewer => myRole == MemberRole.viewer;

  int get totalCount => _items.length;
  int get completedCount => _items.where((i) => i.isCompleted).length;
  double get progress => totalCount > 0 ? completedCount / totalCount : 0.0;

  List<TodoItem> get filteredItems {
    if (_cachedFilteredItems != null) return _cachedFilteredItems!;

    var list = _items;

    // Apply Filter
    switch (_currentFilter) {
      case TodoFilter.all:
        break;
      case TodoFilter.active:
        list = list.where((i) => !i.isCompleted).toList();
        break;
      case TodoFilter.completed:
        list = list.where((i) => i.isCompleted).toList();
        break;
      case TodoFilter.highPriority:
        list = list.where((i) => i.priority == TodoPriority.high).toList();
        break;
      case TodoFilter.assignedToMe:
        final currentUserId = client.auth.authInfo?.authUserId;
        if (currentUserId != null) {
          list = list
              .where((i) => i.assignedToUserId == currentUserId)
              .toList();
        }
        break;
    }

    // Apply Search
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      list = list
          .where(
            (i) =>
                i.title.toLowerCase().contains(query) ||
                (i.description?.toLowerCase().contains(query) ?? false),
          )
          .toList();
    }

    _cachedFilteredItems = list;
    return list;
  }

  void _invalidateCache() {
    _cachedFilteredItems = null;
  }

  void setFilter(TodoFilter filter) {
    if (_currentFilter == filter) return;
    _currentFilter = filter;
    _invalidateCache();
    notifyListeners();
  }

  void setSearchQuery(String query) {
    final clean = query.trim();
    if (_searchQuery == clean) return;
    _searchQuery = clean;
    _invalidateCache();
    notifyListeners();
  }

  Future<void> fetchItems() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _items = await client.todoItem.getItems(listId: listId);
      _invalidateCache();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMembers() async {
    try {
      _members = await client.todoList.getMembers(listId);
      notifyListeners();
    } catch (_) {}
  }

  void _startListening() {
    try {
      final stream = client.todoList.watchList(listId);
      _streamSubscription = stream.listen(
        (event) {
          _handleServerEvent(event);
        },
        onError: (err) {
          // Re-subscribe or log error quietly
        },
      );
    } catch (_) {}
  }

  void _handleServerEvent(TodoListEvent event) {
    if (event.todoListId != listId) return;

    switch (event.eventType) {
      case TodoEventType.itemCreated:
        if (event.todoItem != null) {
          final exists = _items.any((i) => i.id == event.todoItem!.id);
          if (!exists) {
            _items.add(event.todoItem!);
            _items.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
            _invalidateCache();
            notifyListeners();
          }
        }
        break;

      case TodoEventType.itemUpdated:
        if (event.todoItem != null) {
          final index = _items.indexWhere((i) => i.id == event.todoItem!.id);
          if (index != -1) {
            _items[index] = event.todoItem!;
            _invalidateCache();
            notifyListeners();
          } else {
            _items.add(event.todoItem!);
            _items.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
            _invalidateCache();
            notifyListeners();
          }
        }
        break;

      case TodoEventType.itemDeleted:
        if (event.todoItemId != null) {
          _items.removeWhere((i) => i.id == event.todoItemId);
          _invalidateCache();
          notifyListeners();
        }
        break;

      case TodoEventType.memberJoined:
      case TodoEventType.memberRemoved:
        fetchMembers();
        break;

      case TodoEventType.listUpdated:
      case TodoEventType.listDeleted:
        _invalidateCache();
        notifyListeners();
        break;

      case TodoEventType.chatMessageSent:
      case TodoEventType.noteCreated:
      case TodoEventType.noteUpdated:
      case TodoEventType.noteDeleted:
        break;
    }

    _eventController.add(event);
  }

  Future<TodoItem?> createItem({
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
    if (isViewer) {
      _errorMessage = 'Zuschauer können keine Aufgaben anlegen';
      notifyListeners();
      return null;
    }

    try {
      final item = await client.todoItem.createItem(
        listId: listId,
        title: title,
        description: description,
        dueDate: dueDate,
        priority: priority,
        assignedToUserId: assignedToUserId,
        assignedToName: assignedToName,
        subtasksJson: subtasksJson,
        workSessionsJson: workSessionsJson,
        recurrence: recurrence,
      );

      final exists = _items.any((i) => i.id == item.id);
      if (!exists) {
        _items.add(item);
        _invalidateCache();
        notifyListeners();
      }
      return item;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }

  Future<bool> updateItem({
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
    if (isViewer) {
      _errorMessage = 'Zuschauer können keine Aufgaben bearbeiten';
      notifyListeners();
      return false;
    }

    try {
      final updated = await client.todoItem.updateItem(
        itemId: itemId,
        title: title,
        description: description,
        dueDate: dueDate,
        priority: priority,
        assignedToUserId: assignedToUserId,
        assignedToName: assignedToName,
        subtasksJson: subtasksJson,
        workSessionsJson: workSessionsJson,
        recurrence: recurrence,
      );

      final index = _items.indexWhere((i) => i.id == itemId);
      if (index != -1) {
        _items[index] = updated;
        _invalidateCache();
        notifyListeners();
      }
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// Toggles an individual subtask status on a task
  Future<void> toggleSubtask({
    required TodoItem item,
    required String subtaskId,
  }) async {
    if (isViewer) {
      _errorMessage = 'Zuschauer haben nur Leserechte';
      notifyListeners();
      return;
    }

    final subtasks = SubTask.decodeList(item.subtasksJson);
    final target = subtasks.where((s) => s.id == subtaskId).firstOrNull;
    if (target != null) {
      target.isDone = !target.isDone;
      final updatedJson = SubTask.encodeList(subtasks);

      // Optimistic update
      final index = _items.indexWhere((i) => i.id == item.id);
      if (index != -1) {
        _items[index].subtasksJson = updatedJson;
        _invalidateCache();
        notifyListeners();
      }

      try {
        final serverUpdated = await client.todoItem.toggleSubtask(
          itemId: item.id!,
          subtaskId: subtaskId,
        );
        if (index != -1) {
          _items[index] = serverUpdated;
          _invalidateCache();
          notifyListeners();
        }
      } catch (e) {
        _errorMessage = e.toString();
        notifyListeners();
      }
    }
  }

  Future<void> toggleComplete(TodoItem item) async {
    if (isViewer) {
      _errorMessage = 'Zuschauer haben nur Leserechte';
      notifyListeners();
      return;
    }

    // Optimistic UI update
    final index = _items.indexWhere((i) => i.id == item.id);
    if (index != -1) {
      final previous = _items[index];
      _items[index].isCompleted = !previous.isCompleted;
      _invalidateCache();
      notifyListeners();

      try {
        final serverUpdated = await client.todoItem.toggleComplete(
          itemId: item.id!,
        );
        _items[index] = serverUpdated;
        _invalidateCache();
        notifyListeners();
      } catch (e) {
        // Rollback on error
        _items[index] = previous;
        _invalidateCache();
        _errorMessage = e.toString();
        notifyListeners();
      }
    }
  }

  Future<bool> deleteItem(int itemId) async {
    if (isViewer) {
      _errorMessage = 'Zuschauer können keine Aufgaben löschen';
      notifyListeners();
      return false;
    }

    // Optimistic remove
    final index = _items.indexWhere((i) => i.id == itemId);
    if (index == -1) return false;

    final removed = _items.removeAt(index);
    _invalidateCache();
    notifyListeners();

    try {
      final success = await client.todoItem.deleteItem(itemId: itemId);
      if (!success) {
        _items.insert(index, removed);
        _invalidateCache();
        notifyListeners();
      }
      return success;
    } catch (e) {
      _items.insert(index, removed);
      _invalidateCache();
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// Starts work time tracking for a task.
  Future<bool> startTaskTimer(int itemId) async {
    if (isViewer) {
      _errorMessage = 'Zuschauer können keine Zeiterfassung starten';
      notifyListeners();
      return false;
    }

    try {
      final updated = await client.todoItem.startTimer(itemId: itemId);
      final index = _items.indexWhere((i) => i.id == itemId);
      if (index != -1) {
        _items[index] = updated;
        _invalidateCache();
        notifyListeners();
      }
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// Pauses work time tracking for a task and accumulates duration.
  Future<bool> pauseTaskTimer(int itemId) async {
    if (isViewer) return false;

    try {
      final updated = await client.todoItem.pauseTimer(itemId: itemId);
      final index = _items.indexWhere((i) => i.id == itemId);
      if (index != -1) {
        _items[index] = updated;
        _invalidateCache();
        notifyListeners();
      }
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// Calculates the current total elapsed seconds for a task (including currently running session).
  static int getElapsedSeconds(TodoItem item) {
    var total = item.totalDurationSeconds ?? 0;
    if (item.isTimerRunning == true && item.timerStartedAt != null) {
      final runningSession = DateTime.now()
          .difference(item.timerStartedAt!)
          .inSeconds;
      if (runningSession > 0) {
        total += runningSession;
      }
    }
    return total;
  }

  /// Formats seconds into human-readable German duration format, e.g. "1 Std. 25 Min." or "45 Min.".
  static String formatDuration(int totalSeconds) {
    if (totalSeconds <= 0) return '0 Min.';
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;

    if (hours > 0) {
      if (minutes > 0) {
        return '$hours Std. $minutes Min.';
      }
      return '$hours Std.';
    } else if (minutes > 0) {
      return '$minutes Min.';
    } else {
      return '${seconds}s';
    }
  }

  /// Formats seconds into digital timer display format, e.g. "01:24:10" or "04:12".
  static String formatDigitalTime(int totalSeconds) {
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;

    final mStr = minutes.toString().padLeft(2, '0');
    final sStr = seconds.toString().padLeft(2, '0');

    if (hours > 0) {
      final hStr = hours.toString().padLeft(2, '0');
      return '$hStr:$mStr:$sStr';
    }
    return '$mStr:$sStr';
  }

  /// Fetches previous chat messages for this list.
  Future<List<TodoChatMessage>> fetchChatMessages(int listId) async {
    try {
      return await client.todoList.getChatMessages(listId, limit: 60);
    } catch (_) {
      return [];
    }
  }

  /// Sends a chat message in the list discussion (supports public and private direct messages).
  Future<bool> sendChatMessage({
    required int listId,
    required String message,
    UuidValue? recipientUserId,
    String? recipientName,
    bool? isPrivate,
  }) async {
    if (isViewer) {
      _errorMessage = 'Zuschauer können keine Chat-Nachrichten schreiben';
      notifyListeners();
      return false;
    }

    try {
      await client.todoList.sendChatMessage(
        listId: listId,
        message: message,
        recipientUserId: recipientUserId,
        recipientName: recipientName,
        isPrivate: isPrivate,
      );
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// Sends a private 1-on-1 direct message to a specific team member.
  Future<bool> sendPrivateDirectMessage({
    required int listId,
    required UuidValue recipientUserId,
    required String recipientName,
    required String message,
  }) async {
    return await sendChatMessage(
      listId: listId,
      message: message,
      recipientUserId: recipientUserId,
      recipientName: recipientName,
      isPrivate: true,
    );
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _eventController.close();
    super.dispose();
  }
}
