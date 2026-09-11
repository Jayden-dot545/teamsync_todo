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

abstract class TodoChatMessage
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
    required _isc.UuidValue senderUserId,
    required String senderName,
    required _imyvspjt.MemberRole senderRole,
    _isc.UuidValue? recipientUserId,
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
          : _i0z76l7q.Protocol().deserialize<_ixv9ddki.TodoList>(
              jsonSerialization['todoList'],
            ),
      senderUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['senderUserId'],
      ),
      senderName: jsonSerialization['senderName'] as String,
      senderRole: _imyvspjt.MemberRole.fromJson(
        (jsonSerialization['senderRole'] as String),
      ),
      recipientUserId: jsonSerialization['recipientUserId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['recipientUserId'],
            ),
      recipientName: jsonSerialization['recipientName'] as String?,
      isPrivate: jsonSerialization['isPrivate'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isPrivate']),
      message: jsonSerialization['message'] as String,
      sentAt: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['sentAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int todoListId;

  _ixv9ddki.TodoList? todoList;

  _isc.UuidValue senderUserId;

  String senderName;

  _imyvspjt.MemberRole senderRole;

  _isc.UuidValue? recipientUserId;

  String? recipientName;

  bool? isPrivate;

  String message;

  DateTime sentAt;

  /// Returns a shallow copy of this [TodoChatMessage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  TodoChatMessage copyWith({
    int? id,
    int? todoListId,
    _ixv9ddki.TodoList? todoList,
    _isc.UuidValue? senderUserId,
    String? senderName,
    _imyvspjt.MemberRole? senderRole,
    _isc.UuidValue? recipientUserId,
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TodoChatMessageImpl extends TodoChatMessage {
  _TodoChatMessageImpl({
    int? id,
    required int todoListId,
    _ixv9ddki.TodoList? todoList,
    required _isc.UuidValue senderUserId,
    required String senderName,
    required _imyvspjt.MemberRole senderRole,
    _isc.UuidValue? recipientUserId,
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
  @_isc.useResult
  @override
  TodoChatMessage copyWith({
    Object? id = _Undefined,
    int? todoListId,
    Object? todoList = _Undefined,
    _isc.UuidValue? senderUserId,
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
      recipientUserId: recipientUserId is _isc.UuidValue?
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
