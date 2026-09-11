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
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:todolist_client/src/protocol/protocol.dart' as _i0z76l7q;
import '../todos/todo_list.dart' as _ixv9ddki;
import '../todos/todo_priority.dart' as _iuwb4bij;

abstract class TodoItem
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  TodoItem._({
    this.id,
    required this.todoListId,
    this.todoList,
    required this.title,
    this.description,
    required this.isCompleted,
    this.completedAt,
    this.completedByUserId,
    this.completedByName,
    this.dueDate,
    required this.priority,
    this.assignedToUserId,
    this.assignedToName,
    required this.createdById,
    this.createdByName,
    required this.createdAt,
    this.updatedAt,
    required this.sortOrder,
    this.totalDurationSeconds,
    this.timerStartedAt,
    this.isTimerRunning,
    this.timerUserId,
    this.timerUserName,
    this.subtasksJson,
    this.workSessionsJson,
    this.recurrence,
  });

  factory TodoItem({
    int? id,
    required int todoListId,
    _ixv9ddki.TodoList? todoList,
    required String title,
    String? description,
    required bool isCompleted,
    DateTime? completedAt,
    _isc.UuidValue? completedByUserId,
    String? completedByName,
    DateTime? dueDate,
    required _iuwb4bij.TodoPriority priority,
    _isc.UuidValue? assignedToUserId,
    String? assignedToName,
    required _isc.UuidValue createdById,
    String? createdByName,
    required DateTime createdAt,
    DateTime? updatedAt,
    required double sortOrder,
    int? totalDurationSeconds,
    DateTime? timerStartedAt,
    bool? isTimerRunning,
    _isc.UuidValue? timerUserId,
    String? timerUserName,
    String? subtasksJson,
    String? workSessionsJson,
    String? recurrence,
  }) = _TodoItemImpl;

  factory TodoItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return TodoItem(
      id: jsonSerialization['id'] as int?,
      todoListId: jsonSerialization['todoListId'] as int,
      todoList: jsonSerialization['todoList'] == null
          ? null
          : _i0z76l7q.Protocol().deserialize<_ixv9ddki.TodoList>(
              jsonSerialization['todoList'],
            ),
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      isCompleted: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['isCompleted'],
      ),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      completedByUserId: jsonSerialization['completedByUserId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['completedByUserId'],
            ),
      completedByName: jsonSerialization['completedByName'] as String?,
      dueDate: jsonSerialization['dueDate'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['dueDate']),
      priority: _iuwb4bij.TodoPriority.fromJson(
        (jsonSerialization['priority'] as String),
      ),
      assignedToUserId: jsonSerialization['assignedToUserId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['assignedToUserId'],
            ),
      assignedToName: jsonSerialization['assignedToName'] as String?,
      createdById: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['createdById'],
      ),
      createdByName: jsonSerialization['createdByName'] as String?,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      sortOrder: (jsonSerialization['sortOrder'] as num).toDouble(),
      totalDurationSeconds: jsonSerialization['totalDurationSeconds'] as int?,
      timerStartedAt: jsonSerialization['timerStartedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['timerStartedAt'],
            ),
      isTimerRunning: jsonSerialization['isTimerRunning'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(
              jsonSerialization['isTimerRunning'],
            ),
      timerUserId: jsonSerialization['timerUserId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['timerUserId'],
            ),
      timerUserName: jsonSerialization['timerUserName'] as String?,
      subtasksJson: jsonSerialization['subtasksJson'] as String?,
      workSessionsJson: jsonSerialization['workSessionsJson'] as String?,
      recurrence: jsonSerialization['recurrence'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int todoListId;

  _ixv9ddki.TodoList? todoList;

  String title;

  String? description;

  bool isCompleted;

  DateTime? completedAt;

  _isc.UuidValue? completedByUserId;

  String? completedByName;

  DateTime? dueDate;

  _iuwb4bij.TodoPriority priority;

  _isc.UuidValue? assignedToUserId;

  String? assignedToName;

  _isc.UuidValue createdById;

  String? createdByName;

  DateTime createdAt;

  DateTime? updatedAt;

  double sortOrder;

  int? totalDurationSeconds;

  DateTime? timerStartedAt;

  bool? isTimerRunning;

  _isc.UuidValue? timerUserId;

  String? timerUserName;

  String? subtasksJson;

  String? workSessionsJson;

  String? recurrence;

  /// Returns a shallow copy of this [TodoItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  TodoItem copyWith({
    int? id,
    int? todoListId,
    _ixv9ddki.TodoList? todoList,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? completedAt,
    _isc.UuidValue? completedByUserId,
    String? completedByName,
    DateTime? dueDate,
    _iuwb4bij.TodoPriority? priority,
    _isc.UuidValue? assignedToUserId,
    String? assignedToName,
    _isc.UuidValue? createdById,
    String? createdByName,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? sortOrder,
    int? totalDurationSeconds,
    DateTime? timerStartedAt,
    bool? isTimerRunning,
    _isc.UuidValue? timerUserId,
    String? timerUserName,
    String? subtasksJson,
    String? workSessionsJson,
    String? recurrence,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TodoItem',
      if (id != null) 'id': id,
      'todoListId': todoListId,
      if (todoList != null) 'todoList': todoList?.toJson(),
      'title': title,
      if (description != null) 'description': description,
      'isCompleted': isCompleted,
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (completedByUserId != null)
        'completedByUserId': completedByUserId?.toJson(),
      if (completedByName != null) 'completedByName': completedByName,
      if (dueDate != null) 'dueDate': dueDate?.toJson(),
      'priority': priority.toJson(),
      if (assignedToUserId != null)
        'assignedToUserId': assignedToUserId?.toJson(),
      if (assignedToName != null) 'assignedToName': assignedToName,
      'createdById': createdById.toJson(),
      if (createdByName != null) 'createdByName': createdByName,
      'createdAt': createdAt.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      'sortOrder': sortOrder,
      if (totalDurationSeconds != null)
        'totalDurationSeconds': totalDurationSeconds,
      if (timerStartedAt != null) 'timerStartedAt': timerStartedAt?.toJson(),
      if (isTimerRunning != null) 'isTimerRunning': isTimerRunning,
      if (timerUserId != null) 'timerUserId': timerUserId?.toJson(),
      if (timerUserName != null) 'timerUserName': timerUserName,
      if (subtasksJson != null) 'subtasksJson': subtasksJson,
      if (workSessionsJson != null) 'workSessionsJson': workSessionsJson,
      if (recurrence != null) 'recurrence': recurrence,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TodoItem',
      if (id != null) 'id': id,
      'todoListId': todoListId,
      if (todoList != null) 'todoList': todoList?.toJsonForProtocol(),
      'title': title,
      if (description != null) 'description': description,
      'isCompleted': isCompleted,
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (completedByUserId != null)
        'completedByUserId': completedByUserId?.toJson(),
      if (completedByName != null) 'completedByName': completedByName,
      if (dueDate != null) 'dueDate': dueDate?.toJson(),
      'priority': priority.toJson(),
      if (assignedToUserId != null)
        'assignedToUserId': assignedToUserId?.toJson(),
      if (assignedToName != null) 'assignedToName': assignedToName,
      'createdById': createdById.toJson(),
      if (createdByName != null) 'createdByName': createdByName,
      'createdAt': createdAt.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      'sortOrder': sortOrder,
      if (totalDurationSeconds != null)
        'totalDurationSeconds': totalDurationSeconds,
      if (timerStartedAt != null) 'timerStartedAt': timerStartedAt?.toJson(),
      if (isTimerRunning != null) 'isTimerRunning': isTimerRunning,
      if (timerUserId != null) 'timerUserId': timerUserId?.toJson(),
      if (timerUserName != null) 'timerUserName': timerUserName,
      if (subtasksJson != null) 'subtasksJson': subtasksJson,
      if (workSessionsJson != null) 'workSessionsJson': workSessionsJson,
      if (recurrence != null) 'recurrence': recurrence,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TodoItemImpl extends TodoItem {
  _TodoItemImpl({
    int? id,
    required int todoListId,
    _ixv9ddki.TodoList? todoList,
    required String title,
    String? description,
    required bool isCompleted,
    DateTime? completedAt,
    _isc.UuidValue? completedByUserId,
    String? completedByName,
    DateTime? dueDate,
    required _iuwb4bij.TodoPriority priority,
    _isc.UuidValue? assignedToUserId,
    String? assignedToName,
    required _isc.UuidValue createdById,
    String? createdByName,
    required DateTime createdAt,
    DateTime? updatedAt,
    required double sortOrder,
    int? totalDurationSeconds,
    DateTime? timerStartedAt,
    bool? isTimerRunning,
    _isc.UuidValue? timerUserId,
    String? timerUserName,
    String? subtasksJson,
    String? workSessionsJson,
    String? recurrence,
  }) : super._(
         id: id,
         todoListId: todoListId,
         todoList: todoList,
         title: title,
         description: description,
         isCompleted: isCompleted,
         completedAt: completedAt,
         completedByUserId: completedByUserId,
         completedByName: completedByName,
         dueDate: dueDate,
         priority: priority,
         assignedToUserId: assignedToUserId,
         assignedToName: assignedToName,
         createdById: createdById,
         createdByName: createdByName,
         createdAt: createdAt,
         updatedAt: updatedAt,
         sortOrder: sortOrder,
         totalDurationSeconds: totalDurationSeconds,
         timerStartedAt: timerStartedAt,
         isTimerRunning: isTimerRunning,
         timerUserId: timerUserId,
         timerUserName: timerUserName,
         subtasksJson: subtasksJson,
         workSessionsJson: workSessionsJson,
         recurrence: recurrence,
       );

  /// Returns a shallow copy of this [TodoItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  TodoItem copyWith({
    Object? id = _Undefined,
    int? todoListId,
    Object? todoList = _Undefined,
    String? title,
    Object? description = _Undefined,
    bool? isCompleted,
    Object? completedAt = _Undefined,
    Object? completedByUserId = _Undefined,
    Object? completedByName = _Undefined,
    Object? dueDate = _Undefined,
    _iuwb4bij.TodoPriority? priority,
    Object? assignedToUserId = _Undefined,
    Object? assignedToName = _Undefined,
    _isc.UuidValue? createdById,
    Object? createdByName = _Undefined,
    DateTime? createdAt,
    Object? updatedAt = _Undefined,
    double? sortOrder,
    Object? totalDurationSeconds = _Undefined,
    Object? timerStartedAt = _Undefined,
    Object? isTimerRunning = _Undefined,
    Object? timerUserId = _Undefined,
    Object? timerUserName = _Undefined,
    Object? subtasksJson = _Undefined,
    Object? workSessionsJson = _Undefined,
    Object? recurrence = _Undefined,
  }) {
    return TodoItem(
      id: id is int? ? id : this.id,
      todoListId: todoListId ?? this.todoListId,
      todoList: todoList is _ixv9ddki.TodoList?
          ? todoList
          : this.todoList?.copyWith(),
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      completedByUserId: completedByUserId is _isc.UuidValue?
          ? completedByUserId
          : this.completedByUserId,
      completedByName: completedByName is String?
          ? completedByName
          : this.completedByName,
      dueDate: dueDate is DateTime? ? dueDate : this.dueDate,
      priority: priority ?? this.priority,
      assignedToUserId: assignedToUserId is _isc.UuidValue?
          ? assignedToUserId
          : this.assignedToUserId,
      assignedToName: assignedToName is String?
          ? assignedToName
          : this.assignedToName,
      createdById: createdById ?? this.createdById,
      createdByName: createdByName is String?
          ? createdByName
          : this.createdByName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      sortOrder: sortOrder ?? this.sortOrder,
      totalDurationSeconds: totalDurationSeconds is int?
          ? totalDurationSeconds
          : this.totalDurationSeconds,
      timerStartedAt: timerStartedAt is DateTime?
          ? timerStartedAt
          : this.timerStartedAt,
      isTimerRunning: isTimerRunning is bool?
          ? isTimerRunning
          : this.isTimerRunning,
      timerUserId: timerUserId is _isc.UuidValue?
          ? timerUserId
          : this.timerUserId,
      timerUserName: timerUserName is String?
          ? timerUserName
          : this.timerUserName,
      subtasksJson: subtasksJson is String? ? subtasksJson : this.subtasksJson,
      workSessionsJson: workSessionsJson is String?
          ? workSessionsJson
          : this.workSessionsJson,
      recurrence: recurrence is String? ? recurrence : this.recurrence,
    );
  }
}
