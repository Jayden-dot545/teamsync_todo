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

abstract class TodoNote
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  TodoNote._({
    this.id,
    required this.title,
    required this.content,
    required this.todoListId,
    required this.createdById,
    this.createdByName,
    this.color,
    required this.isPinned,
    required this.createdAt,
    this.updatedAt,
  });

  factory TodoNote({
    int? id,
    required String title,
    required String content,
    required int todoListId,
    required _is.UuidValue createdById,
    String? createdByName,
    int? color,
    required bool isPinned,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _TodoNoteImpl;

  factory TodoNote.fromJson(Map<String, dynamic> jsonSerialization) {
    return TodoNote(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      content: jsonSerialization['content'] as String,
      todoListId: jsonSerialization['todoListId'] as int,
      createdById: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['createdById'],
      ),
      createdByName: jsonSerialization['createdByName'] as String?,
      color: jsonSerialization['color'] as int?,
      isPinned: _is.BoolJsonExtension.fromJson(jsonSerialization['isPinned']),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = TodoNoteTable();

  static const db = TodoNoteRepository._();

  @override
  int? id;

  String title;

  String content;

  int todoListId;

  _is.UuidValue createdById;

  String? createdByName;

  int? color;

  bool isPinned;

  DateTime createdAt;

  DateTime? updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [TodoNote]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  TodoNote copyWith({
    int? id,
    String? title,
    String? content,
    int? todoListId,
    _is.UuidValue? createdById,
    String? createdByName,
    int? color,
    bool? isPinned,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TodoNote',
      if (id != null) 'id': id,
      'title': title,
      'content': content,
      'todoListId': todoListId,
      'createdById': createdById.toJson(),
      if (createdByName != null) 'createdByName': createdByName,
      if (color != null) 'color': color,
      'isPinned': isPinned,
      'createdAt': createdAt.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TodoNote',
      if (id != null) 'id': id,
      'title': title,
      'content': content,
      'todoListId': todoListId,
      'createdById': createdById.toJson(),
      if (createdByName != null) 'createdByName': createdByName,
      if (color != null) 'color': color,
      'isPinned': isPinned,
      'createdAt': createdAt.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  static TodoNoteInclude include() {
    return TodoNoteInclude._();
  }

  static TodoNoteIncludeList includeList({
    _is.WhereExpressionBuilder<TodoNoteTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TodoNoteTable>? orderBy,
    _is.OrderByListBuilder<TodoNoteTable>? orderByList,
    TodoNoteInclude? include,
  }) {
    return TodoNoteIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TodoNote.t),
      orderByList: orderByList?.call(TodoNote.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TodoNoteImpl extends TodoNote {
  _TodoNoteImpl({
    int? id,
    required String title,
    required String content,
    required int todoListId,
    required _is.UuidValue createdById,
    String? createdByName,
    int? color,
    required bool isPinned,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         title: title,
         content: content,
         todoListId: todoListId,
         createdById: createdById,
         createdByName: createdByName,
         color: color,
         isPinned: isPinned,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [TodoNote]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  TodoNote copyWith({
    Object? id = _Undefined,
    String? title,
    String? content,
    int? todoListId,
    _is.UuidValue? createdById,
    Object? createdByName = _Undefined,
    Object? color = _Undefined,
    bool? isPinned,
    DateTime? createdAt,
    Object? updatedAt = _Undefined,
  }) {
    return TodoNote(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      todoListId: todoListId ?? this.todoListId,
      createdById: createdById ?? this.createdById,
      createdByName: createdByName is String?
          ? createdByName
          : this.createdByName,
      color: color is int? ? color : this.color,
      isPinned: isPinned ?? this.isPinned,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class TodoNoteUpdateTable extends _is.UpdateTable<TodoNoteTable> {
  TodoNoteUpdateTable(super.table);

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> content(String value) => _is.ColumnValue(
    table.content,
    value,
  );

  _is.ColumnValue<int, int> todoListId(int value) => _is.ColumnValue(
    table.todoListId,
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

  _is.ColumnValue<int, int> color(int? value) => _is.ColumnValue(
    table.color,
    value,
  );

  _is.ColumnValue<bool, bool> isPinned(bool value) => _is.ColumnValue(
    table.isPinned,
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

class TodoNoteTable extends _is.Table<int?> {
  TodoNoteTable({super.tableRelation}) : super(tableName: 'todo_note') {
    updateTable = TodoNoteUpdateTable(this);
    title = _is.ColumnString(
      'title',
      this,
    );
    content = _is.ColumnString(
      'content',
      this,
    );
    todoListId = _is.ColumnInt(
      'todoListId',
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
    color = _is.ColumnInt(
      'color',
      this,
    );
    isPinned = _is.ColumnBool(
      'isPinned',
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

  late final TodoNoteUpdateTable updateTable;

  late final _is.ColumnString title;

  late final _is.ColumnString content;

  late final _is.ColumnInt todoListId;

  late final _is.ColumnUuid createdById;

  late final _is.ColumnString createdByName;

  late final _is.ColumnInt color;

  late final _is.ColumnBool isPinned;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    title,
    content,
    todoListId,
    createdById,
    createdByName,
    color,
    isPinned,
    createdAt,
    updatedAt,
  ];
}

class TodoNoteInclude extends _is.IncludeObject {
  TodoNoteInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => TodoNote.t;
}

class TodoNoteIncludeList extends _is.IncludeList {
  TodoNoteIncludeList._({
    _is.WhereExpressionBuilder<TodoNoteTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TodoNote.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => TodoNote.t;
}

class TodoNoteRepository {
  const TodoNoteRepository._();

  /// Returns a list of [TodoNote]s matching the given query parameters.
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
  Future<List<TodoNote>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TodoNoteTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TodoNoteTable>? orderBy,
    _is.OrderByListBuilder<TodoNoteTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TodoNote>(
      where: where?.call(TodoNote.t),
      orderBy: orderBy?.call(TodoNote.t),
      orderByList: orderByList?.call(TodoNote.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TodoNote] matching the given query parameters.
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
  Future<TodoNote?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TodoNoteTable>? where,
    int? offset,
    _is.OrderByBuilder<TodoNoteTable>? orderBy,
    _is.OrderByListBuilder<TodoNoteTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TodoNote>(
      where: where?.call(TodoNote.t),
      orderBy: orderBy?.call(TodoNote.t),
      orderByList: orderByList?.call(TodoNote.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TodoNote] by its [id] or null if no such row exists.
  Future<TodoNote?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TodoNote>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TodoNote]s in the list and returns the inserted rows.
  ///
  /// The returned [TodoNote]s will have their `id` fields set.
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
  Future<List<TodoNote>> insert(
    _is.DatabaseSession session,
    List<TodoNote> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<TodoNote>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [TodoNote] and returns the inserted row.
  ///
  /// The returned [TodoNote] will have its `id` field set.
  Future<TodoNote> insertRow(
    _is.DatabaseSession session,
    TodoNote row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<TodoNote>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [TodoNote]s in the list and returns the resulting rows.
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
  /// The returned [TodoNote]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TodoNote>> upsert(
    _is.DatabaseSession session,
    List<TodoNote> rows, {
    required _is.ColumnSelections<TodoNoteTable> conflictColumns,
    _is.ColumnSelections<TodoNoteTable>? updateColumns,
    _is.WhereExpressionBuilder<TodoNoteTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<TodoNote>(
      rows,
      conflictColumns: conflictColumns(TodoNote.t),
      updateColumns: updateColumns?.call(TodoNote.t),
      updateWhere: updateWhere?.call(TodoNote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [TodoNote] and returns the resulting row.
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
  /// The returned [TodoNote] will have its `id` field set.
  Future<TodoNote?> upsertRow(
    _is.DatabaseSession session,
    TodoNote row, {
    required _is.ColumnSelections<TodoNoteTable> conflictColumns,
    _is.ColumnSelections<TodoNoteTable>? updateColumns,
    _is.WhereExpressionBuilder<TodoNoteTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<TodoNote>(
      row,
      conflictColumns: conflictColumns(TodoNote.t),
      updateColumns: updateColumns?.call(TodoNote.t),
      updateWhere: updateWhere?.call(TodoNote.t),
      transaction: transaction,
    );
  }

  /// Updates all [TodoNote]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TodoNote>> update(
    _is.DatabaseSession session,
    List<TodoNote> rows, {
    _is.ColumnSelections<TodoNoteTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<TodoNote>(
      rows,
      columns: columns?.call(TodoNote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [TodoNote]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TodoNote> updateRow(
    _is.DatabaseSession session,
    TodoNote row, {
    _is.ColumnSelections<TodoNoteTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<TodoNote>(
      row,
      columns: columns?.call(TodoNote.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TodoNote] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TodoNote?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<TodoNoteUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<TodoNote>(
      id,
      columnValues: columnValues(TodoNote.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TodoNote]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TodoNote>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<TodoNoteUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<TodoNoteTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TodoNoteTable>? orderBy,
    _is.OrderByListBuilder<TodoNoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<TodoNote>(
      columnValues: columnValues(TodoNote.t.updateTable),
      where: where(TodoNote.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TodoNote.t),
      orderByList: orderByList?.call(TodoNote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [TodoNote]s in the list and returns the deleted rows.
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
  Future<List<TodoNote>> delete(
    _is.DatabaseSession session,
    List<TodoNote> rows, {
    _is.OrderByBuilder<TodoNoteTable>? orderBy,
    _is.OrderByListBuilder<TodoNoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<TodoNote>(
      rows,
      orderBy: orderBy?.call(TodoNote.t),
      orderByList: orderByList?.call(TodoNote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [TodoNote].
  Future<TodoNote> deleteRow(
    _is.DatabaseSession session,
    TodoNote row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TodoNote>(
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
  Future<List<TodoNote>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TodoNoteTable> where,
    _is.OrderByBuilder<TodoNoteTable>? orderBy,
    _is.OrderByListBuilder<TodoNoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<TodoNote>(
      where: where(TodoNote.t),
      orderBy: orderBy?.call(TodoNote.t),
      orderByList: orderByList?.call(TodoNote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TodoNoteTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<TodoNote>(
      where: where?.call(TodoNote.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TodoNote] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TodoNoteTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TodoNote>(
      where: where(TodoNote.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
