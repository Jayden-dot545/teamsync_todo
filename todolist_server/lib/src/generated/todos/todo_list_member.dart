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

abstract class TodoListMember
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  TodoListMember._({
    this.id,
    required this.todoListId,
    this.todoList,
    this.userId,
    this.userEmail,
    this.userName,
    this.userBio,
    this.userAvatar,
    this.userStatus,
    required this.role,
    required this.joinedAt,
  });

  factory TodoListMember({
    int? id,
    required int todoListId,
    _ixv9ddki.TodoList? todoList,
    _is.UuidValue? userId,
    String? userEmail,
    String? userName,
    String? userBio,
    String? userAvatar,
    String? userStatus,
    required _imyvspjt.MemberRole role,
    required DateTime joinedAt,
  }) = _TodoListMemberImpl;

  factory TodoListMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return TodoListMember(
      id: jsonSerialization['id'] as int?,
      todoListId: jsonSerialization['todoListId'] as int,
      todoList: jsonSerialization['todoList'] == null
          ? null
          : _ixjhvmd5.Protocol().deserialize<_ixv9ddki.TodoList>(
              jsonSerialization['todoList'],
            ),
      userId: jsonSerialization['userId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      userEmail: jsonSerialization['userEmail'] as String?,
      userName: jsonSerialization['userName'] as String?,
      userBio: jsonSerialization['userBio'] as String?,
      userAvatar: jsonSerialization['userAvatar'] as String?,
      userStatus: jsonSerialization['userStatus'] as String?,
      role: _imyvspjt.MemberRole.fromJson(
        (jsonSerialization['role'] as String),
      ),
      joinedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['joinedAt'],
      ),
    );
  }

  static final t = TodoListMemberTable();

  static const db = TodoListMemberRepository._();

  @override
  int? id;

  int todoListId;

  _ixv9ddki.TodoList? todoList;

  _is.UuidValue? userId;

  String? userEmail;

  String? userName;

  String? userBio;

  String? userAvatar;

  String? userStatus;

  _imyvspjt.MemberRole role;

  DateTime joinedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [TodoListMember]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  TodoListMember copyWith({
    int? id,
    int? todoListId,
    _ixv9ddki.TodoList? todoList,
    _is.UuidValue? userId,
    String? userEmail,
    String? userName,
    String? userBio,
    String? userAvatar,
    String? userStatus,
    _imyvspjt.MemberRole? role,
    DateTime? joinedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TodoListMember',
      if (id != null) 'id': id,
      'todoListId': todoListId,
      if (todoList != null) 'todoList': todoList?.toJson(),
      if (userId != null) 'userId': userId?.toJson(),
      if (userEmail != null) 'userEmail': userEmail,
      if (userName != null) 'userName': userName,
      if (userBio != null) 'userBio': userBio,
      if (userAvatar != null) 'userAvatar': userAvatar,
      if (userStatus != null) 'userStatus': userStatus,
      'role': role.toJson(),
      'joinedAt': joinedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TodoListMember',
      if (id != null) 'id': id,
      'todoListId': todoListId,
      if (todoList != null) 'todoList': todoList?.toJsonForProtocol(),
      if (userId != null) 'userId': userId?.toJson(),
      if (userEmail != null) 'userEmail': userEmail,
      if (userName != null) 'userName': userName,
      if (userBio != null) 'userBio': userBio,
      if (userAvatar != null) 'userAvatar': userAvatar,
      if (userStatus != null) 'userStatus': userStatus,
      'role': role.toJson(),
      'joinedAt': joinedAt.toJson(),
    };
  }

  static TodoListMemberInclude include({_ixv9ddki.TodoListInclude? todoList}) {
    return TodoListMemberInclude._(todoList: todoList);
  }

  static TodoListMemberIncludeList includeList({
    _is.WhereExpressionBuilder<TodoListMemberTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TodoListMemberTable>? orderBy,
    _is.OrderByListBuilder<TodoListMemberTable>? orderByList,
    TodoListMemberInclude? include,
  }) {
    return TodoListMemberIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TodoListMember.t),
      orderByList: orderByList?.call(TodoListMember.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TodoListMemberImpl extends TodoListMember {
  _TodoListMemberImpl({
    int? id,
    required int todoListId,
    _ixv9ddki.TodoList? todoList,
    _is.UuidValue? userId,
    String? userEmail,
    String? userName,
    String? userBio,
    String? userAvatar,
    String? userStatus,
    required _imyvspjt.MemberRole role,
    required DateTime joinedAt,
  }) : super._(
         id: id,
         todoListId: todoListId,
         todoList: todoList,
         userId: userId,
         userEmail: userEmail,
         userName: userName,
         userBio: userBio,
         userAvatar: userAvatar,
         userStatus: userStatus,
         role: role,
         joinedAt: joinedAt,
       );

  /// Returns a shallow copy of this [TodoListMember]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  TodoListMember copyWith({
    Object? id = _Undefined,
    int? todoListId,
    Object? todoList = _Undefined,
    Object? userId = _Undefined,
    Object? userEmail = _Undefined,
    Object? userName = _Undefined,
    Object? userBio = _Undefined,
    Object? userAvatar = _Undefined,
    Object? userStatus = _Undefined,
    _imyvspjt.MemberRole? role,
    DateTime? joinedAt,
  }) {
    return TodoListMember(
      id: id is int? ? id : this.id,
      todoListId: todoListId ?? this.todoListId,
      todoList: todoList is _ixv9ddki.TodoList?
          ? todoList
          : this.todoList?.copyWith(),
      userId: userId is _is.UuidValue? ? userId : this.userId,
      userEmail: userEmail is String? ? userEmail : this.userEmail,
      userName: userName is String? ? userName : this.userName,
      userBio: userBio is String? ? userBio : this.userBio,
      userAvatar: userAvatar is String? ? userAvatar : this.userAvatar,
      userStatus: userStatus is String? ? userStatus : this.userStatus,
      role: role ?? this.role,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }
}

class TodoListMemberUpdateTable extends _is.UpdateTable<TodoListMemberTable> {
  TodoListMemberUpdateTable(super.table);

  _is.ColumnValue<int, int> todoListId(int value) => _is.ColumnValue(
    table.todoListId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> userId(_is.UuidValue? value) =>
      _is.ColumnValue(
        table.userId,
        value,
      );

  _is.ColumnValue<String, String> userEmail(String? value) => _is.ColumnValue(
    table.userEmail,
    value,
  );

  _is.ColumnValue<String, String> userName(String? value) => _is.ColumnValue(
    table.userName,
    value,
  );

  _is.ColumnValue<String, String> userBio(String? value) => _is.ColumnValue(
    table.userBio,
    value,
  );

  _is.ColumnValue<String, String> userAvatar(String? value) => _is.ColumnValue(
    table.userAvatar,
    value,
  );

  _is.ColumnValue<String, String> userStatus(String? value) => _is.ColumnValue(
    table.userStatus,
    value,
  );

  _is.ColumnValue<_imyvspjt.MemberRole, _imyvspjt.MemberRole> role(
    _imyvspjt.MemberRole value,
  ) => _is.ColumnValue(
    table.role,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> joinedAt(DateTime value) =>
      _is.ColumnValue(
        table.joinedAt,
        value,
      );
}

class TodoListMemberTable extends _is.Table<int?> {
  TodoListMemberTable({super.tableRelation})
    : super(tableName: 'todo_list_member') {
    updateTable = TodoListMemberUpdateTable(this);
    todoListId = _is.ColumnInt(
      'todoListId',
      this,
    );
    userId = _is.ColumnUuid(
      'userId',
      this,
    );
    userEmail = _is.ColumnString(
      'userEmail',
      this,
    );
    userName = _is.ColumnString(
      'userName',
      this,
    );
    userBio = _is.ColumnString(
      'userBio',
      this,
    );
    userAvatar = _is.ColumnString(
      'userAvatar',
      this,
    );
    userStatus = _is.ColumnString(
      'userStatus',
      this,
    );
    role = _is.ColumnEnum(
      'role',
      this,
      _is.EnumSerialization.byName,
    );
    joinedAt = _is.ColumnDateTime(
      'joinedAt',
      this,
    );
  }

  late final TodoListMemberUpdateTable updateTable;

  late final _is.ColumnInt todoListId;

  _ixv9ddki.TodoListTable? _todoList;

  late final _is.ColumnUuid userId;

  late final _is.ColumnString userEmail;

  late final _is.ColumnString userName;

  late final _is.ColumnString userBio;

  late final _is.ColumnString userAvatar;

  late final _is.ColumnString userStatus;

  late final _is.ColumnEnum<_imyvspjt.MemberRole> role;

  late final _is.ColumnDateTime joinedAt;

  _ixv9ddki.TodoListTable get todoList {
    if (_todoList != null) return _todoList!;
    _todoList = _is.createRelationTable(
      relationFieldName: 'todoList',
      field: TodoListMember.t.todoListId,
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
    userId,
    userEmail,
    userName,
    userBio,
    userAvatar,
    userStatus,
    role,
    joinedAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'todoList') {
      return todoList;
    }
    return null;
  }
}

class TodoListMemberInclude extends _is.IncludeObject {
  TodoListMemberInclude._({_ixv9ddki.TodoListInclude? todoList}) {
    _todoList = todoList;
  }

  _ixv9ddki.TodoListInclude? _todoList;

  @override
  Map<String, _is.Include?> get includes => {'todoList': _todoList};

  @override
  _is.Table<int?> get table => TodoListMember.t;
}

class TodoListMemberIncludeList extends _is.IncludeList {
  TodoListMemberIncludeList._({
    _is.WhereExpressionBuilder<TodoListMemberTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TodoListMember.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => TodoListMember.t;
}

class TodoListMemberRepository {
  const TodoListMemberRepository._();

  final attachRow = const TodoListMemberAttachRowRepository._();

  /// Returns a list of [TodoListMember]s matching the given query parameters.
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
  Future<List<TodoListMember>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TodoListMemberTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TodoListMemberTable>? orderBy,
    _is.OrderByListBuilder<TodoListMemberTable>? orderByList,
    _is.Transaction? transaction,
    TodoListMemberInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TodoListMember>(
      where: where?.call(TodoListMember.t),
      orderBy: orderBy?.call(TodoListMember.t),
      orderByList: orderByList?.call(TodoListMember.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TodoListMember] matching the given query parameters.
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
  Future<TodoListMember?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TodoListMemberTable>? where,
    int? offset,
    _is.OrderByBuilder<TodoListMemberTable>? orderBy,
    _is.OrderByListBuilder<TodoListMemberTable>? orderByList,
    _is.Transaction? transaction,
    TodoListMemberInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TodoListMember>(
      where: where?.call(TodoListMember.t),
      orderBy: orderBy?.call(TodoListMember.t),
      orderByList: orderByList?.call(TodoListMember.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TodoListMember] by its [id] or null if no such row exists.
  Future<TodoListMember?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    TodoListMemberInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TodoListMember>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TodoListMember]s in the list and returns the inserted rows.
  ///
  /// The returned [TodoListMember]s will have their `id` fields set.
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
  Future<List<TodoListMember>> insert(
    _is.DatabaseSession session,
    List<TodoListMember> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<TodoListMember>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [TodoListMember] and returns the inserted row.
  ///
  /// The returned [TodoListMember] will have its `id` field set.
  Future<TodoListMember> insertRow(
    _is.DatabaseSession session,
    TodoListMember row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<TodoListMember>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [TodoListMember]s in the list and returns the resulting rows.
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
  /// The returned [TodoListMember]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TodoListMember>> upsert(
    _is.DatabaseSession session,
    List<TodoListMember> rows, {
    required _is.ColumnSelections<TodoListMemberTable> conflictColumns,
    _is.ColumnSelections<TodoListMemberTable>? updateColumns,
    _is.WhereExpressionBuilder<TodoListMemberTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<TodoListMember>(
      rows,
      conflictColumns: conflictColumns(TodoListMember.t),
      updateColumns: updateColumns?.call(TodoListMember.t),
      updateWhere: updateWhere?.call(TodoListMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [TodoListMember] and returns the resulting row.
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
  /// The returned [TodoListMember] will have its `id` field set.
  Future<TodoListMember?> upsertRow(
    _is.DatabaseSession session,
    TodoListMember row, {
    required _is.ColumnSelections<TodoListMemberTable> conflictColumns,
    _is.ColumnSelections<TodoListMemberTable>? updateColumns,
    _is.WhereExpressionBuilder<TodoListMemberTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<TodoListMember>(
      row,
      conflictColumns: conflictColumns(TodoListMember.t),
      updateColumns: updateColumns?.call(TodoListMember.t),
      updateWhere: updateWhere?.call(TodoListMember.t),
      transaction: transaction,
    );
  }

  /// Updates all [TodoListMember]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TodoListMember>> update(
    _is.DatabaseSession session,
    List<TodoListMember> rows, {
    _is.ColumnSelections<TodoListMemberTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<TodoListMember>(
      rows,
      columns: columns?.call(TodoListMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [TodoListMember]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TodoListMember> updateRow(
    _is.DatabaseSession session,
    TodoListMember row, {
    _is.ColumnSelections<TodoListMemberTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<TodoListMember>(
      row,
      columns: columns?.call(TodoListMember.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TodoListMember] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TodoListMember?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<TodoListMemberUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<TodoListMember>(
      id,
      columnValues: columnValues(TodoListMember.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TodoListMember]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TodoListMember>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<TodoListMemberUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<TodoListMemberTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TodoListMemberTable>? orderBy,
    _is.OrderByListBuilder<TodoListMemberTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<TodoListMember>(
      columnValues: columnValues(TodoListMember.t.updateTable),
      where: where(TodoListMember.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TodoListMember.t),
      orderByList: orderByList?.call(TodoListMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [TodoListMember]s in the list and returns the deleted rows.
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
  Future<List<TodoListMember>> delete(
    _is.DatabaseSession session,
    List<TodoListMember> rows, {
    _is.OrderByBuilder<TodoListMemberTable>? orderBy,
    _is.OrderByListBuilder<TodoListMemberTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<TodoListMember>(
      rows,
      orderBy: orderBy?.call(TodoListMember.t),
      orderByList: orderByList?.call(TodoListMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [TodoListMember].
  Future<TodoListMember> deleteRow(
    _is.DatabaseSession session,
    TodoListMember row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TodoListMember>(
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
  Future<List<TodoListMember>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TodoListMemberTable> where,
    _is.OrderByBuilder<TodoListMemberTable>? orderBy,
    _is.OrderByListBuilder<TodoListMemberTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<TodoListMember>(
      where: where(TodoListMember.t),
      orderBy: orderBy?.call(TodoListMember.t),
      orderByList: orderByList?.call(TodoListMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TodoListMemberTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<TodoListMember>(
      where: where?.call(TodoListMember.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TodoListMember] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TodoListMemberTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TodoListMember>(
      where: where(TodoListMember.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class TodoListMemberAttachRowRepository {
  const TodoListMemberAttachRowRepository._();

  /// Creates a relation between the given [TodoListMember] and [TodoList]
  /// by setting the [TodoListMember]'s foreign key `todoListId` to refer to the [TodoList].
  Future<void> todoList(
    _is.DatabaseSession session,
    TodoListMember todoListMember,
    _ixv9ddki.TodoList todoList, {
    _is.Transaction? transaction,
  }) async {
    if (todoListMember.id == null) {
      throw ArgumentError.notNull('todoListMember.id');
    }
    if (todoList.id == null) {
      throw ArgumentError.notNull('todoList.id');
    }

    var $todoListMember = todoListMember.copyWith(todoListId: todoList.id);
    await session.db.updateRow<TodoListMember>(
      $todoListMember,
      columns: [TodoListMember.t.todoListId],
      transaction: transaction,
    );
  }
}
