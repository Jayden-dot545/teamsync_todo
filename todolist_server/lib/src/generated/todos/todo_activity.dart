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

abstract class TodoActivity
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  TodoActivity._({
    this.id,
    required this.todoListId,
    this.todoList,
    this.actorUserId,
    required this.actorName,
    required this.actionType,
    required this.details,
    this.targetTitle,
    required this.timestamp,
  });

  factory TodoActivity({
    int? id,
    required int todoListId,
    _ixv9ddki.TodoList? todoList,
    _is.UuidValue? actorUserId,
    required String actorName,
    required String actionType,
    required String details,
    String? targetTitle,
    required DateTime timestamp,
  }) = _TodoActivityImpl;

  factory TodoActivity.fromJson(Map<String, dynamic> jsonSerialization) {
    return TodoActivity(
      id: jsonSerialization['id'] as int?,
      todoListId: jsonSerialization['todoListId'] as int,
      todoList: jsonSerialization['todoList'] == null
          ? null
          : _ixjhvmd5.Protocol().deserialize<_ixv9ddki.TodoList>(
              jsonSerialization['todoList'],
            ),
      actorUserId: jsonSerialization['actorUserId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['actorUserId'],
            ),
      actorName: jsonSerialization['actorName'] as String,
      actionType: jsonSerialization['actionType'] as String,
      details: jsonSerialization['details'] as String,
      targetTitle: jsonSerialization['targetTitle'] as String?,
      timestamp: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
    );
  }

  static final t = TodoActivityTable();

  static const db = TodoActivityRepository._();

  @override
  int? id;

  int todoListId;

  _ixv9ddki.TodoList? todoList;

  _is.UuidValue? actorUserId;

  String actorName;

  String actionType;

  String details;

  String? targetTitle;

  DateTime timestamp;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [TodoActivity]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  TodoActivity copyWith({
    int? id,
    int? todoListId,
    _ixv9ddki.TodoList? todoList,
    _is.UuidValue? actorUserId,
    String? actorName,
    String? actionType,
    String? details,
    String? targetTitle,
    DateTime? timestamp,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TodoActivity',
      if (id != null) 'id': id,
      'todoListId': todoListId,
      if (todoList != null) 'todoList': todoList?.toJson(),
      if (actorUserId != null) 'actorUserId': actorUserId?.toJson(),
      'actorName': actorName,
      'actionType': actionType,
      'details': details,
      if (targetTitle != null) 'targetTitle': targetTitle,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TodoActivity',
      if (id != null) 'id': id,
      'todoListId': todoListId,
      if (todoList != null) 'todoList': todoList?.toJsonForProtocol(),
      if (actorUserId != null) 'actorUserId': actorUserId?.toJson(),
      'actorName': actorName,
      'actionType': actionType,
      'details': details,
      if (targetTitle != null) 'targetTitle': targetTitle,
      'timestamp': timestamp.toJson(),
    };
  }

  static TodoActivityInclude include({_ixv9ddki.TodoListInclude? todoList}) {
    return TodoActivityInclude._(todoList: todoList);
  }

  static TodoActivityIncludeList includeList({
    _is.WhereExpressionBuilder<TodoActivityTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TodoActivityTable>? orderBy,
    _is.OrderByListBuilder<TodoActivityTable>? orderByList,
    TodoActivityInclude? include,
  }) {
    return TodoActivityIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TodoActivity.t),
      orderByList: orderByList?.call(TodoActivity.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TodoActivityImpl extends TodoActivity {
  _TodoActivityImpl({
    int? id,
    required int todoListId,
    _ixv9ddki.TodoList? todoList,
    _is.UuidValue? actorUserId,
    required String actorName,
    required String actionType,
    required String details,
    String? targetTitle,
    required DateTime timestamp,
  }) : super._(
         id: id,
         todoListId: todoListId,
         todoList: todoList,
         actorUserId: actorUserId,
         actorName: actorName,
         actionType: actionType,
         details: details,
         targetTitle: targetTitle,
         timestamp: timestamp,
       );

  /// Returns a shallow copy of this [TodoActivity]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  TodoActivity copyWith({
    Object? id = _Undefined,
    int? todoListId,
    Object? todoList = _Undefined,
    Object? actorUserId = _Undefined,
    String? actorName,
    String? actionType,
    String? details,
    Object? targetTitle = _Undefined,
    DateTime? timestamp,
  }) {
    return TodoActivity(
      id: id is int? ? id : this.id,
      todoListId: todoListId ?? this.todoListId,
      todoList: todoList is _ixv9ddki.TodoList?
          ? todoList
          : this.todoList?.copyWith(),
      actorUserId: actorUserId is _is.UuidValue?
          ? actorUserId
          : this.actorUserId,
      actorName: actorName ?? this.actorName,
      actionType: actionType ?? this.actionType,
      details: details ?? this.details,
      targetTitle: targetTitle is String? ? targetTitle : this.targetTitle,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

class TodoActivityUpdateTable extends _is.UpdateTable<TodoActivityTable> {
  TodoActivityUpdateTable(super.table);

  _is.ColumnValue<int, int> todoListId(int value) => _is.ColumnValue(
    table.todoListId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> actorUserId(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.actorUserId,
    value,
  );

  _is.ColumnValue<String, String> actorName(String value) => _is.ColumnValue(
    table.actorName,
    value,
  );

  _is.ColumnValue<String, String> actionType(String value) => _is.ColumnValue(
    table.actionType,
    value,
  );

  _is.ColumnValue<String, String> details(String value) => _is.ColumnValue(
    table.details,
    value,
  );

  _is.ColumnValue<String, String> targetTitle(String? value) => _is.ColumnValue(
    table.targetTitle,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> timestamp(DateTime value) =>
      _is.ColumnValue(
        table.timestamp,
        value,
      );
}

class TodoActivityTable extends _is.Table<int?> {
  TodoActivityTable({super.tableRelation}) : super(tableName: 'todo_activity') {
    updateTable = TodoActivityUpdateTable(this);
    todoListId = _is.ColumnInt(
      'todoListId',
      this,
    );
    actorUserId = _is.ColumnUuid(
      'actorUserId',
      this,
    );
    actorName = _is.ColumnString(
      'actorName',
      this,
    );
    actionType = _is.ColumnString(
      'actionType',
      this,
    );
    details = _is.ColumnString(
      'details',
      this,
    );
    targetTitle = _is.ColumnString(
      'targetTitle',
      this,
    );
    timestamp = _is.ColumnDateTime(
      'timestamp',
      this,
    );
  }

  late final TodoActivityUpdateTable updateTable;

  late final _is.ColumnInt todoListId;

  _ixv9ddki.TodoListTable? _todoList;

  late final _is.ColumnUuid actorUserId;

  late final _is.ColumnString actorName;

  late final _is.ColumnString actionType;

  late final _is.ColumnString details;

  late final _is.ColumnString targetTitle;

  late final _is.ColumnDateTime timestamp;

  _ixv9ddki.TodoListTable get todoList {
    if (_todoList != null) return _todoList!;
    _todoList = _is.createRelationTable(
      relationFieldName: 'todoList',
      field: TodoActivity.t.todoListId,
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
    actorUserId,
    actorName,
    actionType,
    details,
    targetTitle,
    timestamp,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'todoList') {
      return todoList;
    }
    return null;
  }
}

class TodoActivityInclude extends _is.IncludeObject {
  TodoActivityInclude._({_ixv9ddki.TodoListInclude? todoList}) {
    _todoList = todoList;
  }

  _ixv9ddki.TodoListInclude? _todoList;

  @override
  Map<String, _is.Include?> get includes => {'todoList': _todoList};

  @override
  _is.Table<int?> get table => TodoActivity.t;
}

class TodoActivityIncludeList extends _is.IncludeList {
  TodoActivityIncludeList._({
    _is.WhereExpressionBuilder<TodoActivityTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TodoActivity.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => TodoActivity.t;
}

class TodoActivityRepository {
  const TodoActivityRepository._();

  final attachRow = const TodoActivityAttachRowRepository._();

  /// Returns a list of [TodoActivity]s matching the given query parameters.
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
  Future<List<TodoActivity>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TodoActivityTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TodoActivityTable>? orderBy,
    _is.OrderByListBuilder<TodoActivityTable>? orderByList,
    _is.Transaction? transaction,
    TodoActivityInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TodoActivity>(
      where: where?.call(TodoActivity.t),
      orderBy: orderBy?.call(TodoActivity.t),
      orderByList: orderByList?.call(TodoActivity.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TodoActivity] matching the given query parameters.
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
  Future<TodoActivity?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TodoActivityTable>? where,
    int? offset,
    _is.OrderByBuilder<TodoActivityTable>? orderBy,
    _is.OrderByListBuilder<TodoActivityTable>? orderByList,
    _is.Transaction? transaction,
    TodoActivityInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TodoActivity>(
      where: where?.call(TodoActivity.t),
      orderBy: orderBy?.call(TodoActivity.t),
      orderByList: orderByList?.call(TodoActivity.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TodoActivity] by its [id] or null if no such row exists.
  Future<TodoActivity?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    TodoActivityInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TodoActivity>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TodoActivity]s in the list and returns the inserted rows.
  ///
  /// The returned [TodoActivity]s will have their `id` fields set.
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
  Future<List<TodoActivity>> insert(
    _is.DatabaseSession session,
    List<TodoActivity> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<TodoActivity>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [TodoActivity] and returns the inserted row.
  ///
  /// The returned [TodoActivity] will have its `id` field set.
  Future<TodoActivity> insertRow(
    _is.DatabaseSession session,
    TodoActivity row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<TodoActivity>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [TodoActivity]s in the list and returns the resulting rows.
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
  /// The returned [TodoActivity]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TodoActivity>> upsert(
    _is.DatabaseSession session,
    List<TodoActivity> rows, {
    required _is.ColumnSelections<TodoActivityTable> conflictColumns,
    _is.ColumnSelections<TodoActivityTable>? updateColumns,
    _is.WhereExpressionBuilder<TodoActivityTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<TodoActivity>(
      rows,
      conflictColumns: conflictColumns(TodoActivity.t),
      updateColumns: updateColumns?.call(TodoActivity.t),
      updateWhere: updateWhere?.call(TodoActivity.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [TodoActivity] and returns the resulting row.
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
  /// The returned [TodoActivity] will have its `id` field set.
  Future<TodoActivity?> upsertRow(
    _is.DatabaseSession session,
    TodoActivity row, {
    required _is.ColumnSelections<TodoActivityTable> conflictColumns,
    _is.ColumnSelections<TodoActivityTable>? updateColumns,
    _is.WhereExpressionBuilder<TodoActivityTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<TodoActivity>(
      row,
      conflictColumns: conflictColumns(TodoActivity.t),
      updateColumns: updateColumns?.call(TodoActivity.t),
      updateWhere: updateWhere?.call(TodoActivity.t),
      transaction: transaction,
    );
  }

  /// Updates all [TodoActivity]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TodoActivity>> update(
    _is.DatabaseSession session,
    List<TodoActivity> rows, {
    _is.ColumnSelections<TodoActivityTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<TodoActivity>(
      rows,
      columns: columns?.call(TodoActivity.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [TodoActivity]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TodoActivity> updateRow(
    _is.DatabaseSession session,
    TodoActivity row, {
    _is.ColumnSelections<TodoActivityTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<TodoActivity>(
      row,
      columns: columns?.call(TodoActivity.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TodoActivity] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TodoActivity?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<TodoActivityUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<TodoActivity>(
      id,
      columnValues: columnValues(TodoActivity.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TodoActivity]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TodoActivity>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<TodoActivityUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<TodoActivityTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TodoActivityTable>? orderBy,
    _is.OrderByListBuilder<TodoActivityTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<TodoActivity>(
      columnValues: columnValues(TodoActivity.t.updateTable),
      where: where(TodoActivity.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TodoActivity.t),
      orderByList: orderByList?.call(TodoActivity.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [TodoActivity]s in the list and returns the deleted rows.
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
  Future<List<TodoActivity>> delete(
    _is.DatabaseSession session,
    List<TodoActivity> rows, {
    _is.OrderByBuilder<TodoActivityTable>? orderBy,
    _is.OrderByListBuilder<TodoActivityTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<TodoActivity>(
      rows,
      orderBy: orderBy?.call(TodoActivity.t),
      orderByList: orderByList?.call(TodoActivity.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [TodoActivity].
  Future<TodoActivity> deleteRow(
    _is.DatabaseSession session,
    TodoActivity row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TodoActivity>(
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
  Future<List<TodoActivity>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TodoActivityTable> where,
    _is.OrderByBuilder<TodoActivityTable>? orderBy,
    _is.OrderByListBuilder<TodoActivityTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<TodoActivity>(
      where: where(TodoActivity.t),
      orderBy: orderBy?.call(TodoActivity.t),
      orderByList: orderByList?.call(TodoActivity.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TodoActivityTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<TodoActivity>(
      where: where?.call(TodoActivity.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TodoActivity] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TodoActivityTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TodoActivity>(
      where: where(TodoActivity.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class TodoActivityAttachRowRepository {
  const TodoActivityAttachRowRepository._();

  /// Creates a relation between the given [TodoActivity] and [TodoList]
  /// by setting the [TodoActivity]'s foreign key `todoListId` to refer to the [TodoList].
  Future<void> todoList(
    _is.DatabaseSession session,
    TodoActivity todoActivity,
    _ixv9ddki.TodoList todoList, {
    _is.Transaction? transaction,
  }) async {
    if (todoActivity.id == null) {
      throw ArgumentError.notNull('todoActivity.id');
    }
    if (todoList.id == null) {
      throw ArgumentError.notNull('todoList.id');
    }

    var $todoActivity = todoActivity.copyWith(todoListId: todoList.id);
    await session.db.updateRow<TodoActivity>(
      $todoActivity,
      columns: [TodoActivity.t.todoListId],
      transaction: transaction,
    );
  }
}
