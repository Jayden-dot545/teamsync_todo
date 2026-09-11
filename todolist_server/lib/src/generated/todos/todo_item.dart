/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;
import 'package:todolist_server/src/generated/protocol.dart' as _ixjhvmd5;
import '../todos/todo_list.dart' as _ixv9ddki;
import '../todos/todo_priority.dart' as _iuwb4bij;

abstract class TodoItem
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
    _is.UuidValue? completedByUserId,
    String? completedByName,
    DateTime? dueDate,
    required _iuwb4bij.TodoPriority priority,
    _is.UuidValue? assignedToUserId,
    String? assignedToName,
    required _is.UuidValue createdById,
    String? createdByName,
    required DateTime createdAt,
    DateTime? updatedAt,
    required double sortOrder,
    int? totalDurationSeconds,
    DateTime? timerStartedAt,
    bool? isTimerRunning,
    _is.UuidValue? timerUserId,
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
          : _ixjhvmd5.Protocol().deserialize<_ixv9ddki.TodoList>(
              jsonSerialization['todoList'],
            ),
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      isCompleted: _is.BoolJsonExtension.fromJson(
        jsonSerialization['isCompleted'],
      ),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      completedByUserId: jsonSerialization['completedByUserId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['completedByUserId'],
            ),
      completedByName: jsonSerialization['completedByName'] as String?,
      dueDate: jsonSerialization['dueDate'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['dueDate']),
      priority: _iuwb4bij.TodoPriority.fromJson(
        (jsonSerialization['priority'] as String),
      ),
      assignedToUserId: jsonSerialization['assignedToUserId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['assignedToUserId'],
            ),
      assignedToName: jsonSerialization['assignedToName'] as String?,
      createdById: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['createdById'],
      ),
      createdByName: jsonSerialization['createdByName'] as String?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      sortOrder: (jsonSerialization['sortOrder'] as num).toDouble(),
      totalDurationSeconds: jsonSerialization['totalDurationSeconds'] as int?,
      timerStartedAt: jsonSerialization['timerStartedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['timerStartedAt'],
            ),
      isTimerRunning: jsonSerialization['isTimerRunning'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isTimerRunning']),
      timerUserId: jsonSerialization['timerUserId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['timerUserId'],
            ),
      timerUserName: jsonSerialization['timerUserName'] as String?,
      subtasksJson: jsonSerialization['subtasksJson'] as String?,
      workSessionsJson: jsonSerialization['workSessionsJson'] as String?,
      recurrence: jsonSerialization['recurrence'] as String?,
    );
  }

  static final t = TodoItemTable();

  static const db = TodoItemRepository._();

  @override
  int? id;

  int todoListId;

  _ixv9ddki.TodoList? todoList;

  String title;

  String? description;

  bool isCompleted;

  DateTime? completedAt;

  _is.UuidValue? completedByUserId;

  String? completedByName;

  DateTime? dueDate;

  _iuwb4bij.TodoPriority priority;

  _is.UuidValue? assignedToUserId;

  String? assignedToName;

  _is.UuidValue createdById;

  String? createdByName;

  DateTime createdAt;

  DateTime? updatedAt;

  double sortOrder;

  int? totalDurationSeconds;

  DateTime? timerStartedAt;

  bool? isTimerRunning;

  _is.UuidValue? timerUserId;

  String? timerUserName;

  String? subtasksJson;

  String? workSessionsJson;

  String? recurrence;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [TodoItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  TodoItem copyWith({
    int? id,
    int? todoListId,
    _ixv9ddki.TodoList? todoList,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? completedAt,
    _is.UuidValue? completedByUserId,
    String? completedByName,
    DateTime? dueDate,
    _iuwb4bij.TodoPriority? priority,
    _is.UuidValue? assignedToUserId,
    String? assignedToName,
    _is.UuidValue? createdById,
    String? createdByName,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? sortOrder,
    int? totalDurationSeconds,
    DateTime? timerStartedAt,
    bool? isTimerRunning,
    _is.UuidValue? timerUserId,
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

  static TodoItemInclude include({_ixv9ddki.TodoListInclude? todoList}) {
    return TodoItemInclude._(todoList: todoList);
  }

  static TodoItemIncludeList includeList({
    _is.WhereExpressionBuilder<TodoItemTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TodoItemTable>? orderBy,
    _is.OrderByListBuilder<TodoItemTable>? orderByList,
    TodoItemInclude? include,
  }) {
    return TodoItemIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TodoItem.t),
      orderByList: orderByList?.call(TodoItem.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
    _is.UuidValue? completedByUserId,
    String? completedByName,
    DateTime? dueDate,
    required _iuwb4bij.TodoPriority priority,
    _is.UuidValue? assignedToUserId,
    String? assignedToName,
    required _is.UuidValue createdById,
    String? createdByName,
    required DateTime createdAt,
    DateTime? updatedAt,
    required double sortOrder,
    int? totalDurationSeconds,
    DateTime? timerStartedAt,
    bool? isTimerRunning,
    _is.UuidValue? timerUserId,
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
  @_is.useResult
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
    _is.UuidValue? createdById,
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
      completedByUserId: completedByUserId is _is.UuidValue?
          ? completedByUserId
          : this.completedByUserId,
      completedByName: completedByName is String?
          ? completedByName
          : this.completedByName,
      dueDate: dueDate is DateTime? ? dueDate : this.dueDate,
      priority: priority ?? this.priority,
      assignedToUserId: assignedToUserId is _is.UuidValue?
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
      timerUserId: timerUserId is _is.UuidValue?
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

class TodoItemUpdateTable extends _is.UpdateTable<TodoItemTable> {
  TodoItemUpdateTable(super.table);

  _is.ColumnValue<int, int> todoListId(int value) => _is.ColumnValue(
    table.todoListId,
    value,
  );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> description(String? value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<bool, bool> isCompleted(bool value) => _is.ColumnValue(
    table.isCompleted,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> completedAt(DateTime? value) =>
      _is.ColumnValue(
        table.completedAt,
        value,
      );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> completedByUserId(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.completedByUserId,
    value,
  );

  _is.ColumnValue<String, String> completedByName(String? value) =>
      _is.ColumnValue(
        table.completedByName,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> dueDate(DateTime? value) =>
      _is.ColumnValue(
        table.dueDate,
        value,
      );

  _is.ColumnValue<_iuwb4bij.TodoPriority, _iuwb4bij.TodoPriority> priority(
    _iuwb4bij.TodoPriority value,
  ) => _is.ColumnValue(
    table.priority,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> assignedToUserId(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.assignedToUserId,
    value,
  );

  _is.ColumnValue<String, String> assignedToName(String? value) =>
      _is.ColumnValue(
        table.assignedToName,
        value,
      );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> createdById(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.createdById,
    value,
  );

  _is.ColumnValue<String, String> createdByName(String? value) =>
      _is.ColumnValue(
        table.createdByName,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime? value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );

  _is.ColumnValue<double, double> sortOrder(double value) => _is.ColumnValue(
    table.sortOrder,
    value,
  );

  _is.ColumnValue<int, int> totalDurationSeconds(int? value) => _is.ColumnValue(
    table.totalDurationSeconds,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> timerStartedAt(DateTime? value) =>
      _is.ColumnValue(
        table.timerStartedAt,
        value,
      );

  _is.ColumnValue<bool, bool> isTimerRunning(bool? value) => _is.ColumnValue(
    table.isTimerRunning,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> timerUserId(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.timerUserId,
    value,
  );

  _is.ColumnValue<String, String> timerUserName(String? value) =>
      _is.ColumnValue(
        table.timerUserName,
        value,
      );

  _is.ColumnValue<String, String> subtasksJson(String? value) =>
      _is.ColumnValue(
        table.subtasksJson,
        value,
      );

  _is.ColumnValue<String, String> workSessionsJson(String? value) =>
      _is.ColumnValue(
        table.workSessionsJson,
        value,
      );

  _is.ColumnValue<String, String> recurrence(String? value) => _is.ColumnValue(
    table.recurrence,
    value,
  );
}

class TodoItemTable extends _is.Table<int?> {
  TodoItemTable({super.tableRelation}) : super(tableName: 'todo_item') {
    updateTable = TodoItemUpdateTable(this);
    todoListId = _is.ColumnInt(
      'todoListId',
      this,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    isCompleted = _is.ColumnBool(
      'isCompleted',
      this,
    );
    completedAt = _is.ColumnDateTime(
      'completedAt',
      this,
    );
    completedByUserId = _is.ColumnUuid(
      'completedByUserId',
      this,
    );
    completedByName = _is.ColumnString(
      'completedByName',
      this,
    );
    dueDate = _is.ColumnDateTime(
      'dueDate',
      this,
    );
    priority = _is.ColumnEnum(
      'priority',
      this,
      _is.EnumSerialization.byName,
    );
    assignedToUserId = _is.ColumnUuid(
      'assignedToUserId',
      this,
    );
    assignedToName = _is.ColumnString(
      'assignedToName',
      this,
    );
    createdById = _is.ColumnUuid(
      'createdById',
      this,
    );
    createdByName = _is.ColumnString(
      'createdByName',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
    sortOrder = _is.ColumnDouble(
      'sortOrder',
      this,
    );
    totalDurationSeconds = _is.ColumnInt(
      'totalDurationSeconds',
      this,
    );
    timerStartedAt = _is.ColumnDateTime(
      'timerStartedAt',
      this,
    );
    isTimerRunning = _is.ColumnBool(
      'isTimerRunning',
      this,
    );
    timerUserId = _is.ColumnUuid(
      'timerUserId',
      this,
    );
    timerUserName = _is.ColumnString(
      'timerUserName',
      this,
    );
    subtasksJson = _is.ColumnString(
      'subtasksJson',
      this,
    );
    workSessionsJson = _is.ColumnString(
      'workSessionsJson',
      this,
    );
    recurrence = _is.ColumnString(
      'recurrence',
      this,
    );
  }

  late final TodoItemUpdateTable updateTable;

  late final _is.ColumnInt todoListId;

  _ixv9ddki.TodoListTable? _todoList;

  late final _is.ColumnString title;

  late final _is.ColumnString description;

  late final _is.ColumnBool isCompleted;

  late final _is.ColumnDateTime completedAt;

  late final _is.ColumnUuid completedByUserId;

  late final _is.ColumnString completedByName;

  late final _is.ColumnDateTime dueDate;

  late final _is.ColumnEnum<_iuwb4bij.TodoPriority> priority;

  late final _is.ColumnUuid assignedToUserId;

  late final _is.ColumnString assignedToName;

  late final _is.ColumnUuid createdById;

  late final _is.ColumnString createdByName;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  late final _is.ColumnDouble sortOrder;

  late final _is.ColumnInt totalDurationSeconds;

  late final _is.ColumnDateTime timerStartedAt;

  late final _is.ColumnBool isTimerRunning;

  late final _is.ColumnUuid timerUserId;

  late final _is.ColumnString timerUserName;

  late final _is.ColumnString subtasksJson;

  late final _is.ColumnString workSessionsJson;

  late final _is.ColumnString recurrence;

  _ixv9ddki.TodoListTable get todoList {
    if (_todoList != null) return _todoList!;
    _todoList = _is.createRelationTable(
      relationFieldName: 'todoList',
      field: TodoItem.t.todoListId,
      foreignField: _ixv9ddki.TodoList.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ixv9ddki.TodoListTable(tableRelation: foreignTableRelation),
    );
    return _todoList!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    todoListId,
    title,
    description,
    isCompleted,
    completedAt,
    completedByUserId,
    completedByName,
    dueDate,
    priority,
    assignedToUserId,
    assignedToName,
    createdById,
    createdByName,
    createdAt,
    updatedAt,
    sortOrder,
    totalDurationSeconds,
    timerStartedAt,
    isTimerRunning,
    timerUserId,
    timerUserName,
    subtasksJson,
    workSessionsJson,
    recurrence,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'todoList') {
      return todoList;
    }
    return null;
  }
}

class TodoItemInclude extends _is.IncludeObject {
  TodoItemInclude._({_ixv9ddki.TodoListInclude? todoList}) {
    _todoList = todoList;
  }

  _ixv9ddki.TodoListInclude? _todoList;

  @override
  Map<String, _is.Include?> get includes => {'todoList': _todoList};

  @override
  _is.Table<int?> get table => TodoItem.t;
}

class TodoItemIncludeList extends _is.IncludeList {
  TodoItemIncludeList._({
    _is.WhereExpressionBuilder<TodoItemTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TodoItem.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => TodoItem.t;
}

class TodoItemRepository {
  const TodoItemRepository._();

  final attachRow = const TodoItemAttachRowRepository._();

  /// Returns a list of [TodoItem]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<TodoItem>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TodoItemTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TodoItemTable>? orderBy,
    _is.OrderByListBuilder<TodoItemTable>? orderByList,
    _is.Transaction? transaction,
    TodoItemInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TodoItem>(
      where: where?.call(TodoItem.t),
      orderBy: orderBy?.call(TodoItem.t),
      orderByList: orderByList?.call(TodoItem.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TodoItem] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<TodoItem?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TodoItemTable>? where,
    int? offset,
    _is.OrderByBuilder<TodoItemTable>? orderBy,
    _is.OrderByListBuilder<TodoItemTable>? orderByList,
    _is.Transaction? transaction,
    TodoItemInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TodoItem>(
      where: where?.call(TodoItem.t),
      orderBy: orderBy?.call(TodoItem.t),
      orderByList: orderByList?.call(TodoItem.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TodoItem] by its [id] or null if no such row exists.
  Future<TodoItem?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    TodoItemInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TodoItem>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TodoItem]s in the list and returns the inserted rows.
  ///
  /// The returned [TodoItem]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TodoItem>> insert(
    _is.DatabaseSession session,
    List<TodoItem> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<TodoItem>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [TodoItem] and returns the inserted row.
  ///
  /// The returned [TodoItem] will have its `id` field set.
  Future<TodoItem> insertRow(
    _is.DatabaseSession session,
    TodoItem row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<TodoItem>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [TodoItem]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [TodoItem]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TodoItem>> upsert(
    _is.DatabaseSession session,
    List<TodoItem> rows, {
    required _is.ColumnSelections<TodoItemTable> conflictColumns,
    _is.ColumnSelections<TodoItemTable>? updateColumns,
    _is.WhereExpressionBuilder<TodoItemTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<TodoItem>(
      rows,
      conflictColumns: conflictColumns(TodoItem.t),
      updateColumns: updateColumns?.call(TodoItem.t),
      updateWhere: updateWhere?.call(TodoItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [TodoItem] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [TodoItem] will have its `id` field set.
  Future<TodoItem?> upsertRow(
    _is.DatabaseSession session,
    TodoItem row, {
    required _is.ColumnSelections<TodoItemTable> conflictColumns,
    _is.ColumnSelections<TodoItemTable>? updateColumns,
    _is.WhereExpressionBuilder<TodoItemTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<TodoItem>(
      row,
      conflictColumns: conflictColumns(TodoItem.t),
      updateColumns: updateColumns?.call(TodoItem.t),
      updateWhere: updateWhere?.call(TodoItem.t),
      transaction: transaction,
    );
  }

  /// Updates all [TodoItem]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TodoItem>> update(
    _is.DatabaseSession session,
    List<TodoItem> rows, {
    _is.ColumnSelections<TodoItemTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<TodoItem>(
      rows,
      columns: columns?.call(TodoItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [TodoItem]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TodoItem> updateRow(
    _is.DatabaseSession session,
    TodoItem row, {
    _is.ColumnSelections<TodoItemTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<TodoItem>(
      row,
      columns: columns?.call(TodoItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TodoItem] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TodoItem?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<TodoItemUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<TodoItem>(
      id,
      columnValues: columnValues(TodoItem.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TodoItem]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TodoItem>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<TodoItemUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<TodoItemTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TodoItemTable>? orderBy,
    _is.OrderByListBuilder<TodoItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<TodoItem>(
      columnValues: columnValues(TodoItem.t.updateTable),
      where: where(TodoItem.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TodoItem.t),
      orderByList: orderByList?.call(TodoItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [TodoItem]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TodoItem>> delete(
    _is.DatabaseSession session,
    List<TodoItem> rows, {
    _is.OrderByBuilder<TodoItemTable>? orderBy,
    _is.OrderByListBuilder<TodoItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<TodoItem>(
      rows,
      orderBy: orderBy?.call(TodoItem.t),
      orderByList: orderByList?.call(TodoItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [TodoItem].
  Future<TodoItem> deleteRow(
    _is.DatabaseSession session,
    TodoItem row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TodoItem>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TodoItem>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TodoItemTable> where,
    _is.OrderByBuilder<TodoItemTable>? orderBy,
    _is.OrderByListBuilder<TodoItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<TodoItem>(
      where: where(TodoItem.t),
      orderBy: orderBy?.call(TodoItem.t),
      orderByList: orderByList?.call(TodoItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TodoItemTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<TodoItem>(
      where: where?.call(TodoItem.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TodoItem] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TodoItemTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TodoItem>(
      where: where(TodoItem.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class TodoItemAttachRowRepository {
  const TodoItemAttachRowRepository._();

  /// Creates a relation between the given [TodoItem] and [TodoList]
  /// by setting the [TodoItem]'s foreign key `todoListId` to refer to the [TodoList].
  Future<void> todoList(
    _is.DatabaseSession session,
    TodoItem todoItem,
    _ixv9ddki.TodoList todoList, {
    _is.Transaction? transaction,
  }) async {
    if (todoItem.id == null) {
      throw ArgumentError.notNull('todoItem.id');
    }
    if (todoList.id == null) {
      throw ArgumentError.notNull('todoList.id');
    }

    var $todoItem = todoItem.copyWith(todoListId: todoList.id);
    await session.db.updateRow<TodoItem>(
      $todoItem,
      columns: [TodoItem.t.todoListId],
      transaction: transaction,
    );
  }
}
