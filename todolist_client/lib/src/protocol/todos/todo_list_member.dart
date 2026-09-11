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
import '../todos/member_role.dart' as _imyvspjt;
import '../todos/todo_list.dart' as _ixv9ddki;

abstract class TodoListMember
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
    _isc.UuidValue? userId,
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
          : _i0z76l7q.Protocol().deserialize<_ixv9ddki.TodoList>(
              jsonSerialization['todoList'],
            ),
      userId: jsonSerialization['userId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      userEmail: jsonSerialization['userEmail'] as String?,
      userName: jsonSerialization['userName'] as String?,
      userBio: jsonSerialization['userBio'] as String?,
      userAvatar: jsonSerialization['userAvatar'] as String?,
      userStatus: jsonSerialization['userStatus'] as String?,
      role: _imyvspjt.MemberRole.fromJson(
        (jsonSerialization['role'] as String),
      ),
      joinedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['joinedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int todoListId;

  _ixv9ddki.TodoList? todoList;

  _isc.UuidValue? userId;

  String? userEmail;

  String? userName;

  String? userBio;

  String? userAvatar;

  String? userStatus;

  _imyvspjt.MemberRole role;

  DateTime joinedAt;

  /// Returns a shallow copy of this [TodoListMember]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  TodoListMember copyWith({
    int? id,
    int? todoListId,
    _ixv9ddki.TodoList? todoList,
    _isc.UuidValue? userId,
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TodoListMemberImpl extends TodoListMember {
  _TodoListMemberImpl({
    int? id,
    required int todoListId,
    _ixv9ddki.TodoList? todoList,
    _isc.UuidValue? userId,
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
  @_isc.useResult
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
      userId: userId is _isc.UuidValue? ? userId : this.userId,
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
