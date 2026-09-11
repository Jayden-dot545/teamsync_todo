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
import 'package:serverpod/serverpod.dart' as _is;

abstract class TodoList
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  TodoList._({
    this.id,
    required this.title,
    this.description,
    required this.color,
    required this.ownerId,
    this.inviteCode,
    required this.createdAt,
    this.updatedAt,
  });

  factory TodoList({
    int? id,
    required String title,
    String? description,
    required int color,
    required _is.UuidValue ownerId,
    String? inviteCode,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _TodoListImpl;

  factory TodoList.fromJson(Map<String, dynamic> jsonSerialization) {
    return TodoList(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      color: jsonSerialization['color'] as int,
      ownerId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      inviteCode: jsonSerialization['inviteCode'] as String?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = TodoListTable();

  static const db = TodoListRepository._();

  @override
  int? id;

  String title;

  String? description;

  int color;

  _is.UuidValue ownerId;

  String? inviteCode;

  DateTime createdAt;

  DateTime? updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [TodoList]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  TodoList copyWith({
    int? id,
    String? title,
    String? description,
    int? color,
    _is.UuidValue? ownerId,
    String? inviteCode,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TodoList',
      if (id != null) 'id': id,
      'title': title,
      if (description != null) 'description': description,
      'color': color,
      'ownerId': ownerId.toJson(),
      if (inviteCode != null) 'inviteCode': inviteCode,
      'createdAt': createdAt.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TodoList',
      if (id != null) 'id': id,
      'title': title,
      if (description != null) 'description': description,
      'color': color,
      'ownerId': ownerId.toJson(),
      if (inviteCode != null) 'inviteCode': inviteCode,
      'createdAt': createdAt.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  static TodoListInclude include() {
    return TodoListInclude._();
  }

  static TodoListIncludeList includeList({
    _is.WhereExpressionBuilder<TodoListTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TodoListTable>? orderBy,
    _is.OrderByListBuilder<TodoListTable>? orderByList,
    TodoListInclude? include,
  }) {
    return TodoListIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TodoList.t),
      orderByList: orderByList?.call(TodoList.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TodoListImpl extends TodoList {
  _TodoListImpl({
    int? id,
    required String title,
    String? description,
    required int color,
    required _is.UuidValue ownerId,
    String? inviteCode,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         title: title,
         description: description,
         color: color,
         ownerId: ownerId,
         inviteCode: inviteCode,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [TodoList]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  TodoList copyWith({
    Object? id = _Undefined,
    String? title,
    Object? description = _Undefined,
    int? color,
    _is.UuidValue? ownerId,
    Object? inviteCode = _Undefined,
    DateTime? createdAt,
    Object? updatedAt = _Undefined,
  }) {
    return TodoList(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      color: color ?? this.color,
      ownerId: ownerId ?? this.ownerId,
      inviteCode: inviteCode is String? ? inviteCode : this.inviteCode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class TodoListUpdateTable extends _is.UpdateTable<TodoListTable> {
  TodoListUpdateTable(super.table);

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> description(String? value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<int, int> color(int value) => _is.ColumnValue(
    table.color,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> ownerId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.ownerId,
        value,
      );

  _is.ColumnValue<String, String> inviteCode(String? value) => _is.ColumnValue(
    table.inviteCode,
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
}

class TodoListTable extends _is.Table<int?> {
  TodoListTable({super.tableRelation}) : super(tableName: 'todo_list') {
    updateTable = TodoListUpdateTable(this);
    title = _is.ColumnString(
      'title',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    color = _is.ColumnInt(
      'color',
      this,
    );
    ownerId = _is.ColumnUuid(
      'ownerId',
      this,
    );
    inviteCode = _is.ColumnString(
      'inviteCode',
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
  }

  late final TodoListUpdateTable updateTable;

  late final _is.ColumnString title;

  late final _is.ColumnString description;

  late final _is.ColumnInt color;

  late final _is.ColumnUuid ownerId;

  late final _is.ColumnString inviteCode;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    title,
    description,
    color,
    ownerId,
    inviteCode,
    createdAt,
    updatedAt,
  ];
}

class TodoListInclude extends _is.IncludeObject {
  TodoListInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => TodoList.t;
}

class TodoListIncludeList extends _is.IncludeList {
  TodoListIncludeList._({
    _is.WhereExpressionBuilder<TodoListTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TodoList.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => TodoList.t;
}

class TodoListRepository {
  const TodoListRepository._();

  /// Returns a list of [TodoList]s matching the given query parameters.
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
  Future<List<TodoList>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TodoListTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TodoListTable>? orderBy,
    _is.OrderByListBuilder<TodoListTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TodoList>(
      where: where?.call(TodoList.t),
      orderBy: orderBy?.call(TodoList.t),
      orderByList: orderByList?.call(TodoList.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TodoList] matching the given query parameters.
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
  Future<TodoList?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TodoListTable>? where,
    int? offset,
    _is.OrderByBuilder<TodoListTable>? orderBy,
    _is.OrderByListBuilder<TodoListTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TodoList>(
      where: where?.call(TodoList.t),
      orderBy: orderBy?.call(TodoList.t),
      orderByList: orderByList?.call(TodoList.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TodoList] by its [id] or null if no such row exists.
  Future<TodoList?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TodoList>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TodoList]s in the list and returns the inserted rows.
  ///
  /// The returned [TodoList]s will have their `id` fields set.
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
  Future<List<TodoList>> insert(
    _is.DatabaseSession session,
    List<TodoList> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<TodoList>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [TodoList] and returns the inserted row.
  ///
  /// The returned [TodoList] will have its `id` field set.
  Future<TodoList> insertRow(
    _is.DatabaseSession session,
    TodoList row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<TodoList>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [TodoList]s in the list and returns the resulting rows.
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
  /// The returned [TodoList]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TodoList>> upsert(
    _is.DatabaseSession session,
    List<TodoList> rows, {
    required _is.ColumnSelections<TodoListTable> conflictColumns,
    _is.ColumnSelections<TodoListTable>? updateColumns,
    _is.WhereExpressionBuilder<TodoListTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<TodoList>(
      rows,
      conflictColumns: conflictColumns(TodoList.t),
      updateColumns: updateColumns?.call(TodoList.t),
      updateWhere: updateWhere?.call(TodoList.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [TodoList] and returns the resulting row.
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
  /// The returned [TodoList] will have its `id` field set.
  Future<TodoList?> upsertRow(
    _is.DatabaseSession session,
    TodoList row, {
    required _is.ColumnSelections<TodoListTable> conflictColumns,
    _is.ColumnSelections<TodoListTable>? updateColumns,
    _is.WhereExpressionBuilder<TodoListTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<TodoList>(
      row,
      conflictColumns: conflictColumns(TodoList.t),
      updateColumns: updateColumns?.call(TodoList.t),
      updateWhere: updateWhere?.call(TodoList.t),
      transaction: transaction,
    );
  }

  /// Updates all [TodoList]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TodoList>> update(
    _is.DatabaseSession session,
    List<TodoList> rows, {
    _is.ColumnSelections<TodoListTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<TodoList>(
      rows,
      columns: columns?.call(TodoList.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [TodoList]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TodoList> updateRow(
    _is.DatabaseSession session,
    TodoList row, {
    _is.ColumnSelections<TodoListTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<TodoList>(
      row,
      columns: columns?.call(TodoList.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TodoList] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TodoList?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<TodoListUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<TodoList>(
      id,
      columnValues: columnValues(TodoList.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TodoList]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TodoList>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<TodoListUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<TodoListTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TodoListTable>? orderBy,
    _is.OrderByListBuilder<TodoListTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<TodoList>(
      columnValues: columnValues(TodoList.t.updateTable),
      where: where(TodoList.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TodoList.t),
      orderByList: orderByList?.call(TodoList.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [TodoList]s in the list and returns the deleted rows.
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
  Future<List<TodoList>> delete(
    _is.DatabaseSession session,
    List<TodoList> rows, {
    _is.OrderByBuilder<TodoListTable>? orderBy,
    _is.OrderByListBuilder<TodoListTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<TodoList>(
      rows,
      orderBy: orderBy?.call(TodoList.t),
      orderByList: orderByList?.call(TodoList.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [TodoList].
  Future<TodoList> deleteRow(
    _is.DatabaseSession session,
    TodoList row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TodoList>(
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
  Future<List<TodoList>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TodoListTable> where,
    _is.OrderByBuilder<TodoListTable>? orderBy,
    _is.OrderByListBuilder<TodoListTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<TodoList>(
      where: where(TodoList.t),
      orderBy: orderBy?.call(TodoList.t),
      orderByList: orderByList?.call(TodoList.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TodoListTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<TodoList>(
      where: where?.call(TodoList.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TodoList] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TodoListTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TodoList>(
      where: where(TodoList.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
