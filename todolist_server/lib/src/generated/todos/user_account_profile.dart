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

abstract class UserAccountProfile
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  UserAccountProfile._({
    this.id,
    required this.userId,
    this.email,
    this.displayName,
    this.bio,
    this.avatarIndex,
    this.avatarEmoji,
    this.status,
    this.themeMode,
    this.notificationsEnabled,
    this.locale,
    required this.updatedAt,
  });

  factory UserAccountProfile({
    int? id,
    required _is.UuidValue userId,
    String? email,
    String? displayName,
    String? bio,
    int? avatarIndex,
    String? avatarEmoji,
    String? status,
    String? themeMode,
    bool? notificationsEnabled,
    String? locale,
    required DateTime updatedAt,
  }) = _UserAccountProfileImpl;

  factory UserAccountProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserAccountProfile(
      id: jsonSerialization['id'] as int?,
      userId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      email: jsonSerialization['email'] as String?,
      displayName: jsonSerialization['displayName'] as String?,
      bio: jsonSerialization['bio'] as String?,
      avatarIndex: jsonSerialization['avatarIndex'] as int?,
      avatarEmoji: jsonSerialization['avatarEmoji'] as String?,
      status: jsonSerialization['status'] as String?,
      themeMode: jsonSerialization['themeMode'] as String?,
      notificationsEnabled: jsonSerialization['notificationsEnabled'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['notificationsEnabled'],
            ),
      locale: jsonSerialization['locale'] as String?,
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = UserAccountProfileTable();

  static const db = UserAccountProfileRepository._();

  @override
  int? id;

  _is.UuidValue userId;

  String? email;

  String? displayName;

  String? bio;

  int? avatarIndex;

  String? avatarEmoji;

  String? status;

  String? themeMode;

  bool? notificationsEnabled;

  String? locale;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserAccountProfile]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  UserAccountProfile copyWith({
    int? id,
    _is.UuidValue? userId,
    String? email,
    String? displayName,
    String? bio,
    int? avatarIndex,
    String? avatarEmoji,
    String? status,
    String? themeMode,
    bool? notificationsEnabled,
    String? locale,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserAccountProfile',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (email != null) 'email': email,
      if (displayName != null) 'displayName': displayName,
      if (bio != null) 'bio': bio,
      if (avatarIndex != null) 'avatarIndex': avatarIndex,
      if (avatarEmoji != null) 'avatarEmoji': avatarEmoji,
      if (status != null) 'status': status,
      if (themeMode != null) 'themeMode': themeMode,
      if (notificationsEnabled != null)
        'notificationsEnabled': notificationsEnabled,
      if (locale != null) 'locale': locale,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserAccountProfile',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (email != null) 'email': email,
      if (displayName != null) 'displayName': displayName,
      if (bio != null) 'bio': bio,
      if (avatarIndex != null) 'avatarIndex': avatarIndex,
      if (avatarEmoji != null) 'avatarEmoji': avatarEmoji,
      if (status != null) 'status': status,
      if (themeMode != null) 'themeMode': themeMode,
      if (notificationsEnabled != null)
        'notificationsEnabled': notificationsEnabled,
      if (locale != null) 'locale': locale,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static UserAccountProfileInclude include() {
    return UserAccountProfileInclude._();
  }

  static UserAccountProfileIncludeList includeList({
    _is.WhereExpressionBuilder<UserAccountProfileTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserAccountProfileTable>? orderBy,
    _is.OrderByListBuilder<UserAccountProfileTable>? orderByList,
    UserAccountProfileInclude? include,
  }) {
    return UserAccountProfileIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserAccountProfile.t),
      orderByList: orderByList?.call(UserAccountProfile.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserAccountProfileImpl extends UserAccountProfile {
  _UserAccountProfileImpl({
    int? id,
    required _is.UuidValue userId,
    String? email,
    String? displayName,
    String? bio,
    int? avatarIndex,
    String? avatarEmoji,
    String? status,
    String? themeMode,
    bool? notificationsEnabled,
    String? locale,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         email: email,
         displayName: displayName,
         bio: bio,
         avatarIndex: avatarIndex,
         avatarEmoji: avatarEmoji,
         status: status,
         themeMode: themeMode,
         notificationsEnabled: notificationsEnabled,
         locale: locale,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [UserAccountProfile]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  UserAccountProfile copyWith({
    Object? id = _Undefined,
    _is.UuidValue? userId,
    Object? email = _Undefined,
    Object? displayName = _Undefined,
    Object? bio = _Undefined,
    Object? avatarIndex = _Undefined,
    Object? avatarEmoji = _Undefined,
    Object? status = _Undefined,
    Object? themeMode = _Undefined,
    Object? notificationsEnabled = _Undefined,
    Object? locale = _Undefined,
    DateTime? updatedAt,
  }) {
    return UserAccountProfile(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      email: email is String? ? email : this.email,
      displayName: displayName is String? ? displayName : this.displayName,
      bio: bio is String? ? bio : this.bio,
      avatarIndex: avatarIndex is int? ? avatarIndex : this.avatarIndex,
      avatarEmoji: avatarEmoji is String? ? avatarEmoji : this.avatarEmoji,
      status: status is String? ? status : this.status,
      themeMode: themeMode is String? ? themeMode : this.themeMode,
      notificationsEnabled: notificationsEnabled is bool?
          ? notificationsEnabled
          : this.notificationsEnabled,
      locale: locale is String? ? locale : this.locale,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class UserAccountProfileUpdateTable
    extends _is.UpdateTable<UserAccountProfileTable> {
  UserAccountProfileUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> userId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.userId,
        value,
      );

  _is.ColumnValue<String, String> email(String? value) => _is.ColumnValue(
    table.email,
    value,
  );

  _is.ColumnValue<String, String> displayName(String? value) => _is.ColumnValue(
    table.displayName,
    value,
  );

  _is.ColumnValue<String, String> bio(String? value) => _is.ColumnValue(
    table.bio,
    value,
  );

  _is.ColumnValue<int, int> avatarIndex(int? value) => _is.ColumnValue(
    table.avatarIndex,
    value,
  );

  _is.ColumnValue<String, String> avatarEmoji(String? value) => _is.ColumnValue(
    table.avatarEmoji,
    value,
  );

  _is.ColumnValue<String, String> status(String? value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> themeMode(String? value) => _is.ColumnValue(
    table.themeMode,
    value,
  );

  _is.ColumnValue<bool, bool> notificationsEnabled(bool? value) =>
      _is.ColumnValue(
        table.notificationsEnabled,
        value,
      );

  _is.ColumnValue<String, String> locale(String? value) => _is.ColumnValue(
    table.locale,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class UserAccountProfileTable extends _is.Table<int?> {
  UserAccountProfileTable({super.tableRelation})
    : super(tableName: 'user_account_profile') {
    updateTable = UserAccountProfileUpdateTable(this);
    userId = _is.ColumnUuid(
      'userId',
      this,
    );
    email = _is.ColumnString(
      'email',
      this,
    );
    displayName = _is.ColumnString(
      'displayName',
      this,
    );
    bio = _is.ColumnString(
      'bio',
      this,
    );
    avatarIndex = _is.ColumnInt(
      'avatarIndex',
      this,
    );
    avatarEmoji = _is.ColumnString(
      'avatarEmoji',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    themeMode = _is.ColumnString(
      'themeMode',
      this,
    );
    notificationsEnabled = _is.ColumnBool(
      'notificationsEnabled',
      this,
    );
    locale = _is.ColumnString(
      'locale',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final UserAccountProfileUpdateTable updateTable;

  late final _is.ColumnUuid userId;

  late final _is.ColumnString email;

  late final _is.ColumnString displayName;

  late final _is.ColumnString bio;

  late final _is.ColumnInt avatarIndex;

  late final _is.ColumnString avatarEmoji;

  late final _is.ColumnString status;

  late final _is.ColumnString themeMode;

  late final _is.ColumnBool notificationsEnabled;

  late final _is.ColumnString locale;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    email,
    displayName,
    bio,
    avatarIndex,
    avatarEmoji,
    status,
    themeMode,
    notificationsEnabled,
    locale,
    updatedAt,
  ];
}

class UserAccountProfileInclude extends _is.IncludeObject {
  UserAccountProfileInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => UserAccountProfile.t;
}

class UserAccountProfileIncludeList extends _is.IncludeList {
  UserAccountProfileIncludeList._({
    _is.WhereExpressionBuilder<UserAccountProfileTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserAccountProfile.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => UserAccountProfile.t;
}

class UserAccountProfileRepository {
  const UserAccountProfileRepository._();

  /// Returns a list of [UserAccountProfile]s matching the given query parameters.
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
  Future<List<UserAccountProfile>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserAccountProfileTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserAccountProfileTable>? orderBy,
    _is.OrderByListBuilder<UserAccountProfileTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<UserAccountProfile>(
      where: where?.call(UserAccountProfile.t),
      orderBy: orderBy?.call(UserAccountProfile.t),
      orderByList: orderByList?.call(UserAccountProfile.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [UserAccountProfile] matching the given query parameters.
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
  Future<UserAccountProfile?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserAccountProfileTable>? where,
    int? offset,
    _is.OrderByBuilder<UserAccountProfileTable>? orderBy,
    _is.OrderByListBuilder<UserAccountProfileTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<UserAccountProfile>(
      where: where?.call(UserAccountProfile.t),
      orderBy: orderBy?.call(UserAccountProfile.t),
      orderByList: orderByList?.call(UserAccountProfile.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [UserAccountProfile] by its [id] or null if no such row exists.
  Future<UserAccountProfile?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<UserAccountProfile>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [UserAccountProfile]s in the list and returns the inserted rows.
  ///
  /// The returned [UserAccountProfile]s will have their `id` fields set.
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
  Future<List<UserAccountProfile>> insert(
    _is.DatabaseSession session,
    List<UserAccountProfile> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<UserAccountProfile>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [UserAccountProfile] and returns the inserted row.
  ///
  /// The returned [UserAccountProfile] will have its `id` field set.
  Future<UserAccountProfile> insertRow(
    _is.DatabaseSession session,
    UserAccountProfile row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserAccountProfile>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [UserAccountProfile]s in the list and returns the resulting rows.
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
  /// The returned [UserAccountProfile]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserAccountProfile>> upsert(
    _is.DatabaseSession session,
    List<UserAccountProfile> rows, {
    required _is.ColumnSelections<UserAccountProfileTable> conflictColumns,
    _is.ColumnSelections<UserAccountProfileTable>? updateColumns,
    _is.WhereExpressionBuilder<UserAccountProfileTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<UserAccountProfile>(
      rows,
      conflictColumns: conflictColumns(UserAccountProfile.t),
      updateColumns: updateColumns?.call(UserAccountProfile.t),
      updateWhere: updateWhere?.call(UserAccountProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [UserAccountProfile] and returns the resulting row.
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
  /// The returned [UserAccountProfile] will have its `id` field set.
  Future<UserAccountProfile?> upsertRow(
    _is.DatabaseSession session,
    UserAccountProfile row, {
    required _is.ColumnSelections<UserAccountProfileTable> conflictColumns,
    _is.ColumnSelections<UserAccountProfileTable>? updateColumns,
    _is.WhereExpressionBuilder<UserAccountProfileTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<UserAccountProfile>(
      row,
      conflictColumns: conflictColumns(UserAccountProfile.t),
      updateColumns: updateColumns?.call(UserAccountProfile.t),
      updateWhere: updateWhere?.call(UserAccountProfile.t),
      transaction: transaction,
    );
  }

  /// Updates all [UserAccountProfile]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserAccountProfile>> update(
    _is.DatabaseSession session,
    List<UserAccountProfile> rows, {
    _is.ColumnSelections<UserAccountProfileTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<UserAccountProfile>(
      rows,
      columns: columns?.call(UserAccountProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [UserAccountProfile]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserAccountProfile> updateRow(
    _is.DatabaseSession session,
    UserAccountProfile row, {
    _is.ColumnSelections<UserAccountProfileTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserAccountProfile>(
      row,
      columns: columns?.call(UserAccountProfile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserAccountProfile] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserAccountProfile?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<UserAccountProfileUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<UserAccountProfile>(
      id,
      columnValues: columnValues(UserAccountProfile.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserAccountProfile]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserAccountProfile>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<UserAccountProfileUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<UserAccountProfileTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserAccountProfileTable>? orderBy,
    _is.OrderByListBuilder<UserAccountProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<UserAccountProfile>(
      columnValues: columnValues(UserAccountProfile.t.updateTable),
      where: where(UserAccountProfile.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserAccountProfile.t),
      orderByList: orderByList?.call(UserAccountProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [UserAccountProfile]s in the list and returns the deleted rows.
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
  Future<List<UserAccountProfile>> delete(
    _is.DatabaseSession session,
    List<UserAccountProfile> rows, {
    _is.OrderByBuilder<UserAccountProfileTable>? orderBy,
    _is.OrderByListBuilder<UserAccountProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<UserAccountProfile>(
      rows,
      orderBy: orderBy?.call(UserAccountProfile.t),
      orderByList: orderByList?.call(UserAccountProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [UserAccountProfile].
  Future<UserAccountProfile> deleteRow(
    _is.DatabaseSession session,
    UserAccountProfile row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserAccountProfile>(
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
  Future<List<UserAccountProfile>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<UserAccountProfileTable> where,
    _is.OrderByBuilder<UserAccountProfileTable>? orderBy,
    _is.OrderByListBuilder<UserAccountProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<UserAccountProfile>(
      where: where(UserAccountProfile.t),
      orderBy: orderBy?.call(UserAccountProfile.t),
      orderByList: orderByList?.call(UserAccountProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserAccountProfileTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<UserAccountProfile>(
      where: where?.call(UserAccountProfile.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [UserAccountProfile] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<UserAccountProfileTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<UserAccountProfile>(
      where: where(UserAccountProfile.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
