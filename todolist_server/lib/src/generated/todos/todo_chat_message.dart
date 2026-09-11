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
import '../todos/member_role.dart' as _imyvspjt;
import '../todos/todo_list.dart' as _ixv9ddki;

abstract class TodoChatMessage
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  TodoChatMessage._({
    this.id,
    required this.todoListId,
    this.todoList,
    required this.senderUserId,
    required this.senderName,
    required this.senderRole,
    this.recipientUserId,
    this.recipientName,
    this.isPrivate,
    required this.message,
    required this.sentAt,
  });

  factory TodoChatMessage({
    int? id,
    required int todoListId,
    _ixv9ddki.TodoList? todoList,
    required _is.UuidValue senderUserId,
    required String senderName,
    required _imyvspjt.MemberRole senderRole,
    _is.UuidValue? recipientUserId,
    String? recipientName,
    bool? isPrivate,
    required String message,
    required DateTime sentAt,
  }) = _TodoChatMessageImpl;

  factory TodoChatMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return TodoChatMessage(
      id: jsonSerialization['id'] as int?,
      todoListId: jsonSerialization['todoListId'] as int,
      todoList: jsonSerialization['todoList'] == null
          ? null
          : _ixjhvmd5.Protocol().deserialize<_ixv9ddki.TodoList>(
              jsonSerialization['todoList'],
            ),
      senderUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['senderUserId'],
      ),
      senderName: jsonSerialization['senderName'] as String,
      senderRole: _imyvspjt.MemberRole.fromJson(
        (jsonSerialization['senderRole'] as String),
      ),
      recipientUserId: jsonSerialization['recipientUserId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['recipientUserId'],
            ),
      recipientName: jsonSerialization['recipientName'] as String?,
      isPrivate: jsonSerialization['isPrivate'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isPrivate']),
      message: jsonSerialization['message'] as String,
      sentAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['sentAt']),
    );
  }

  static final t = TodoChatMessageTable();

  static const db = TodoChatMessageRepository._();

  @override
  int? id;

  int todoListId;

  _ixv9ddki.TodoList? todoList;

  _is.UuidValue senderUserId;

  String senderName;

  _imyvspjt.MemberRole senderRole;

  _is.UuidValue? recipientUserId;

  String? recipientName;

  bool? isPrivate;

  String message;

  DateTime sentAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [TodoChatMessage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  TodoChatMessage copyWith({
    int? id,
    int? todoListId,
    _ixv9ddki.TodoList? todoList,
    _is.UuidValue? senderUserId,
    String? senderName,
    _imyvspjt.MemberRole? senderRole,
    _is.UuidValue? recipientUserId,
    String? recipientName,
    bool? isPrivate,
    String? message,
    DateTime? sentAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TodoChatMessage',
      if (id != null) 'id': id,
      'todoListId': todoListId,
      if (todoList != null) 'todoList': todoList?.toJson(),
      'senderUserId': senderUserId.toJson(),
      'senderName': senderName,
      'senderRole': senderRole.toJson(),
      if (recipientUserId != null) 'recipientUserId': recipientUserId?.toJson(),
      if (recipientName != null) 'recipientName': recipientName,
      if (isPrivate != null) 'isPrivate': isPrivate,
      'message': message,
      'sentAt': sentAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TodoChatMessage',
      if (id != null) 'id': id,
      'todoListId': todoListId,
      if (todoList != null) 'todoList': todoList?.toJsonForProtocol(),
      'senderUserId': senderUserId.toJson(),
      'senderName': senderName,
      'senderRole': senderRole.toJson(),
      if (recipientUserId != null) 'recipientUserId': recipientUserId?.toJson(),
      if (recipientName != null) 'recipientName': recipientName,
      if (isPrivate != null) 'isPrivate': isPrivate,
      'message': message,
      'sentAt': sentAt.toJson(),
    };
  }

  static TodoChatMessageInclude include({_ixv9ddki.TodoListInclude? todoList}) {
    return TodoChatMessageInclude._(todoList: todoList);
  }

  static TodoChatMessageIncludeList includeList({
    _is.WhereExpressionBuilder<TodoChatMessageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TodoChatMessageTable>? orderBy,
    _is.OrderByListBuilder<TodoChatMessageTable>? orderByList,
    TodoChatMessageInclude? include,
  }) {
    return TodoChatMessageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TodoChatMessage.t),
      orderByList: orderByList?.call(TodoChatMessage.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TodoChatMessageImpl extends TodoChatMessage {
  _TodoChatMessageImpl({
    int? id,
    required int todoListId,
    _ixv9ddki.TodoList? todoList,
    required _is.UuidValue senderUserId,
    required String senderName,
    required _imyvspjt.MemberRole senderRole,
    _is.UuidValue? recipientUserId,
    String? recipientName,
    bool? isPrivate,
    required String message,
    required DateTime sentAt,
  }) : super._(
         id: id,
         todoListId: todoListId,
         todoList: todoList,
         senderUserId: senderUserId,
         senderName: senderName,
         senderRole: senderRole,
         recipientUserId: recipientUserId,
         recipientName: recipientName,
         isPrivate: isPrivate,
         message: message,
         sentAt: sentAt,
       );

  /// Returns a shallow copy of this [TodoChatMessage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  TodoChatMessage copyWith({
    Object? id = _Undefined,
    int? todoListId,
    Object? todoList = _Undefined,
    _is.UuidValue? senderUserId,
    String? senderName,
    _imyvspjt.MemberRole? senderRole,
    Object? recipientUserId = _Undefined,
    Object? recipientName = _Undefined,
    Object? isPrivate = _Undefined,
    String? message,
    DateTime? sentAt,
  }) {
    return TodoChatMessage(
      id: id is int? ? id : this.id,
      todoListId: todoListId ?? this.todoListId,
      todoList: todoList is _ixv9ddki.TodoList?
          ? todoList
          : this.todoList?.copyWith(),
      senderUserId: senderUserId ?? this.senderUserId,
      senderName: senderName ?? this.senderName,
      senderRole: senderRole ?? this.senderRole,
      recipientUserId: recipientUserId is _is.UuidValue?
          ? recipientUserId
          : this.recipientUserId,
      recipientName: recipientName is String?
          ? recipientName
          : this.recipientName,
      isPrivate: isPrivate is bool? ? isPrivate : this.isPrivate,
      message: message ?? this.message,
      sentAt: sentAt ?? this.sentAt,
    );
  }
}

class TodoChatMessageUpdateTable extends _is.UpdateTable<TodoChatMessageTable> {
  TodoChatMessageUpdateTable(super.table);

  _is.ColumnValue<int, int> todoListId(int value) => _is.ColumnValue(
    table.todoListId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> senderUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.senderUserId,
    value,
  );

  _is.ColumnValue<String, String> senderName(String value) => _is.ColumnValue(
    table.senderName,
    value,
  );

  _is.ColumnValue<_imyvspjt.MemberRole, _imyvspjt.MemberRole> senderRole(
    _imyvspjt.MemberRole value,
  ) => _is.ColumnValue(
    table.senderRole,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> recipientUserId(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.recipientUserId,
    value,
  );

  _is.ColumnValue<String, String> recipientName(String? value) =>
      _is.ColumnValue(
        table.recipientName,
        value,
      );

  _is.ColumnValue<bool, bool> isPrivate(bool? value) => _is.ColumnValue(
    table.isPrivate,
    value,
  );

  _is.ColumnValue<String, String> message(String value) => _is.ColumnValue(
    table.message,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> sentAt(DateTime value) => _is.ColumnValue(
    table.sentAt,
    value,
  );
}

class TodoChatMessageTable extends _is.Table<int?> {
  TodoChatMessageTable({super.tableRelation})
    : super(tableName: 'todo_chat_message') {
    updateTable = TodoChatMessageUpdateTable(this);
    todoListId = _is.ColumnInt(
      'todoListId',
      this,
    );
    senderUserId = _is.ColumnUuid(
      'senderUserId',
      this,
    );
    senderName = _is.ColumnString(
      'senderName',
      this,
    );
    senderRole = _is.ColumnEnum(
      'senderRole',
      this,
      _is.EnumSerialization.byName,
    );
    recipientUserId = _is.ColumnUuid(
      'recipientUserId',
      this,
    );
    recipientName = _is.ColumnString(
      'recipientName',
      this,
    );
    isPrivate = _is.ColumnBool(
      'isPrivate',
      this,
    );
    message = _is.ColumnString(
      'message',
      this,
    );
    sentAt = _is.ColumnDateTime(
      'sentAt',
      this,
    );
  }

  late final TodoChatMessageUpdateTable updateTable;

  late final _is.ColumnInt todoListId;

  _ixv9ddki.TodoListTable? _todoList;

  late final _is.ColumnUuid senderUserId;

  late final _is.ColumnString senderName;

  late final _is.ColumnEnum<_imyvspjt.MemberRole> senderRole;

  late final _is.ColumnUuid recipientUserId;

  late final _is.ColumnString recipientName;

  late final _is.ColumnBool isPrivate;

  late final _is.ColumnString message;

  late final _is.ColumnDateTime sentAt;

  _ixv9ddki.TodoListTable get todoList {
    if (_todoList != null) return _todoList!;
    _todoList = _is.createRelationTable(
      relationFieldName: 'todoList',
      field: TodoChatMessage.t.todoListId,
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
    senderUserId,
    senderName,
    senderRole,
    recipientUserId,
    recipientName,
    isPrivate,
    message,
    sentAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'todoList') {
      return todoList;
    }
    return null;
  }
}

class TodoChatMessageInclude extends _is.IncludeObject {
  TodoChatMessageInclude._({_ixv9ddki.TodoListInclude? todoList}) {
    _todoList = todoList;
  }

  _ixv9ddki.TodoListInclude? _todoList;

  @override
  Map<String, _is.Include?> get includes => {'todoList': _todoList};

  @override
  _is.Table<int?> get table => TodoChatMessage.t;
}

class TodoChatMessageIncludeList extends _is.IncludeList {
  TodoChatMessageIncludeList._({
    _is.WhereExpressionBuilder<TodoChatMessageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TodoChatMessage.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => TodoChatMessage.t;
}

class TodoChatMessageRepository {
  const TodoChatMessageRepository._();

  final attachRow = const TodoChatMessageAttachRowRepository._();

  /// Returns a list of [TodoChatMessage]s matching the given query parameters.
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
  Future<List<TodoChatMessage>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TodoChatMessageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TodoChatMessageTable>? orderBy,
    _is.OrderByListBuilder<TodoChatMessageTable>? orderByList,
    _is.Transaction? transaction,
    TodoChatMessageInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TodoChatMessage>(
      where: where?.call(TodoChatMessage.t),
      orderBy: orderBy?.call(TodoChatMessage.t),
      orderByList: orderByList?.call(TodoChatMessage.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TodoChatMessage] matching the given query parameters.
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
  Future<TodoChatMessage?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TodoChatMessageTable>? where,
    int? offset,
    _is.OrderByBuilder<TodoChatMessageTable>? orderBy,
    _is.OrderByListBuilder<TodoChatMessageTable>? orderByList,
    _is.Transaction? transaction,
    TodoChatMessageInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TodoChatMessage>(
      where: where?.call(TodoChatMessage.t),
      orderBy: orderBy?.call(TodoChatMessage.t),
      orderByList: orderByList?.call(TodoChatMessage.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TodoChatMessage] by its [id] or null if no such row exists.
  Future<TodoChatMessage?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    TodoChatMessageInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TodoChatMessage>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TodoChatMessage]s in the list and returns the inserted rows.
  ///
  /// The returned [TodoChatMessage]s will have their `id` fields set.
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
  Future<List<TodoChatMessage>> insert(
    _is.DatabaseSession session,
    List<TodoChatMessage> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<TodoChatMessage>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [TodoChatMessage] and returns the inserted row.
  ///
  /// The returned [TodoChatMessage] will have its `id` field set.
  Future<TodoChatMessage> insertRow(
    _is.DatabaseSession session,
    TodoChatMessage row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<TodoChatMessage>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [TodoChatMessage]s in the list and returns the resulting rows.
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
  /// The returned [TodoChatMessage]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TodoChatMessage>> upsert(
    _is.DatabaseSession session,
    List<TodoChatMessage> rows, {
    required _is.ColumnSelections<TodoChatMessageTable> conflictColumns,
    _is.ColumnSelections<TodoChatMessageTable>? updateColumns,
    _is.WhereExpressionBuilder<TodoChatMessageTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<TodoChatMessage>(
      rows,
      conflictColumns: conflictColumns(TodoChatMessage.t),
      updateColumns: updateColumns?.call(TodoChatMessage.t),
      updateWhere: updateWhere?.call(TodoChatMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [TodoChatMessage] and returns the resulting row.
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
  /// The returned [TodoChatMessage] will have its `id` field set.
  Future<TodoChatMessage?> upsertRow(
    _is.DatabaseSession session,
    TodoChatMessage row, {
    required _is.ColumnSelections<TodoChatMessageTable> conflictColumns,
    _is.ColumnSelections<TodoChatMessageTable>? updateColumns,
    _is.WhereExpressionBuilder<TodoChatMessageTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<TodoChatMessage>(
      row,
      conflictColumns: conflictColumns(TodoChatMessage.t),
      updateColumns: updateColumns?.call(TodoChatMessage.t),
      updateWhere: updateWhere?.call(TodoChatMessage.t),
      transaction: transaction,
    );
  }

  /// Updates all [TodoChatMessage]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TodoChatMessage>> update(
    _is.DatabaseSession session,
    List<TodoChatMessage> rows, {
    _is.ColumnSelections<TodoChatMessageTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<TodoChatMessage>(
      rows,
      columns: columns?.call(TodoChatMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [TodoChatMessage]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TodoChatMessage> updateRow(
    _is.DatabaseSession session,
    TodoChatMessage row, {
    _is.ColumnSelections<TodoChatMessageTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<TodoChatMessage>(
      row,
      columns: columns?.call(TodoChatMessage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TodoChatMessage] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TodoChatMessage?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<TodoChatMessageUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<TodoChatMessage>(
      id,
      columnValues: columnValues(TodoChatMessage.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TodoChatMessage]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TodoChatMessage>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<TodoChatMessageUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<TodoChatMessageTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TodoChatMessageTable>? orderBy,
    _is.OrderByListBuilder<TodoChatMessageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<TodoChatMessage>(
      columnValues: columnValues(TodoChatMessage.t.updateTable),
      where: where(TodoChatMessage.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TodoChatMessage.t),
      orderByList: orderByList?.call(TodoChatMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [TodoChatMessage]s in the list and returns the deleted rows.
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
  Future<List<TodoChatMessage>> delete(
    _is.DatabaseSession session,
    List<TodoChatMessage> rows, {
    _is.OrderByBuilder<TodoChatMessageTable>? orderBy,
    _is.OrderByListBuilder<TodoChatMessageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<TodoChatMessage>(
      rows,
      orderBy: orderBy?.call(TodoChatMessage.t),
      orderByList: orderByList?.call(TodoChatMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [TodoChatMessage].
  Future<TodoChatMessage> deleteRow(
    _is.DatabaseSession session,
    TodoChatMessage row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TodoChatMessage>(
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
  Future<List<TodoChatMessage>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TodoChatMessageTable> where,
    _is.OrderByBuilder<TodoChatMessageTable>? orderBy,
    _is.OrderByListBuilder<TodoChatMessageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<TodoChatMessage>(
      where: where(TodoChatMessage.t),
      orderBy: orderBy?.call(TodoChatMessage.t),
      orderByList: orderByList?.call(TodoChatMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TodoChatMessageTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<TodoChatMessage>(
      where: where?.call(TodoChatMessage.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TodoChatMessage] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TodoChatMessageTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TodoChatMessage>(
      where: where(TodoChatMessage.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class TodoChatMessageAttachRowRepository {
  const TodoChatMessageAttachRowRepository._();

  /// Creates a relation between the given [TodoChatMessage] and [TodoList]
  /// by setting the [TodoChatMessage]'s foreign key `todoListId` to refer to the [TodoList].
  Future<void> todoList(
    _is.DatabaseSession session,
    TodoChatMessage todoChatMessage,
    _ixv9ddki.TodoList todoList, {
    _is.Transaction? transaction,
  }) async {
    if (todoChatMessage.id == null) {
      throw ArgumentError.notNull('todoChatMessage.id');
    }
    if (todoList.id == null) {
      throw ArgumentError.notNull('todoList.id');
    }

    var $todoChatMessage = todoChatMessage.copyWith(todoListId: todoList.id);
    await session.db.updateRow<TodoChatMessage>(
      $todoChatMessage,
      columns: [TodoChatMessage.t.todoListId],
      transaction: transaction,
    );
  }
}
