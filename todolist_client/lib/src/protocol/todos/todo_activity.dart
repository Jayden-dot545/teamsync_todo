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

abstract class TodoActivity
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
    _isc.UuidValue? actorUserId,
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
          : _i0z76l7q.Protocol().deserialize<_ixv9ddki.TodoList>(
              jsonSerialization['todoList'],
            ),
      actorUserId: jsonSerialization['actorUserId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['actorUserId'],
            ),
      actorName: jsonSerialization['actorName'] as String,
      actionType: jsonSerialization['actionType'] as String,
      details: jsonSerialization['details'] as String,
      targetTitle: jsonSerialization['targetTitle'] as String?,
      timestamp: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int todoListId;

  _ixv9ddki.TodoList? todoList;

  _isc.UuidValue? actorUserId;

  String actorName;

  String actionType;

  String details;

  String? targetTitle;

  DateTime timestamp;

  /// Returns a shallow copy of this [TodoActivity]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  TodoActivity copyWith({
    int? id,
    int? todoListId,
    _ixv9ddki.TodoList? todoList,
    _isc.UuidValue? actorUserId,
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TodoActivityImpl extends TodoActivity {
  _TodoActivityImpl({
    int? id,
    required int todoListId,
    _ixv9ddki.TodoList? todoList,
    _isc.UuidValue? actorUserId,
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
  @_isc.useResult
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
      actorUserId: actorUserId is _isc.UuidValue?
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
