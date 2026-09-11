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
import '../todos/todo_chat_message.dart' as _iwb2uvgt;
import '../todos/todo_event_type.dart' as _ixog04aa;
import '../todos/todo_item.dart' as _i3rw14gz;
import '../todos/todo_list_member.dart' as _if7o0j8k;
import '../todos/todo_note.dart' as _ihqwc0h0;

abstract class TodoListEvent
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  TodoListEvent._({
    required this.todoListId,
    required this.eventType,
    this.todoItem,
    this.todoItemId,
    this.member,
    this.chatMessage,
    this.note,
    this.noteId,
    this.actorName,
    required this.timestamp,
  });

  factory TodoListEvent({
    required int todoListId,
    required _ixog04aa.TodoEventType eventType,
    _i3rw14gz.TodoItem? todoItem,
    int? todoItemId,
    _if7o0j8k.TodoListMember? member,
    _iwb2uvgt.TodoChatMessage? chatMessage,
    _ihqwc0h0.TodoNote? note,
    int? noteId,
    String? actorName,
    required DateTime timestamp,
  }) = _TodoListEventImpl;

  factory TodoListEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return TodoListEvent(
      todoListId: jsonSerialization['todoListId'] as int,
      eventType: _ixog04aa.TodoEventType.fromJson(
        (jsonSerialization['eventType'] as String),
      ),
      todoItem: jsonSerialization['todoItem'] == null
          ? null
          : _i0z76l7q.Protocol().deserialize<_i3rw14gz.TodoItem>(
              jsonSerialization['todoItem'],
            ),
      todoItemId: jsonSerialization['todoItemId'] as int?,
      member: jsonSerialization['member'] == null
          ? null
          : _i0z76l7q.Protocol().deserialize<_if7o0j8k.TodoListMember>(
              jsonSerialization['member'],
            ),
      chatMessage: jsonSerialization['chatMessage'] == null
          ? null
          : _i0z76l7q.Protocol().deserialize<_iwb2uvgt.TodoChatMessage>(
              jsonSerialization['chatMessage'],
            ),
      note: jsonSerialization['note'] == null
          ? null
          : _i0z76l7q.Protocol().deserialize<_ihqwc0h0.TodoNote>(
              jsonSerialization['note'],
            ),
      noteId: jsonSerialization['noteId'] as int?,
      actorName: jsonSerialization['actorName'] as String?,
      timestamp: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
    );
  }

  int todoListId;

  _ixog04aa.TodoEventType eventType;

  _i3rw14gz.TodoItem? todoItem;

  int? todoItemId;

  _if7o0j8k.TodoListMember? member;

  _iwb2uvgt.TodoChatMessage? chatMessage;

  _ihqwc0h0.TodoNote? note;

  int? noteId;

  String? actorName;

  DateTime timestamp;

  /// Returns a shallow copy of this [TodoListEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  TodoListEvent copyWith({
    int? todoListId,
    _ixog04aa.TodoEventType? eventType,
    _i3rw14gz.TodoItem? todoItem,
    int? todoItemId,
    _if7o0j8k.TodoListMember? member,
    _iwb2uvgt.TodoChatMessage? chatMessage,
    _ihqwc0h0.TodoNote? note,
    int? noteId,
    String? actorName,
    DateTime? timestamp,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TodoListEvent',
      'todoListId': todoListId,
      'eventType': eventType.toJson(),
      if (todoItem != null) 'todoItem': todoItem?.toJson(),
      if (todoItemId != null) 'todoItemId': todoItemId,
      if (member != null) 'member': member?.toJson(),
      if (chatMessage != null) 'chatMessage': chatMessage?.toJson(),
      if (note != null) 'note': note?.toJson(),
      if (noteId != null) 'noteId': noteId,
      if (actorName != null) 'actorName': actorName,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TodoListEvent',
      'todoListId': todoListId,
      'eventType': eventType.toJson(),
      if (todoItem != null) 'todoItem': todoItem?.toJsonForProtocol(),
      if (todoItemId != null) 'todoItemId': todoItemId,
      if (member != null) 'member': member?.toJsonForProtocol(),
      if (chatMessage != null) 'chatMessage': chatMessage?.toJsonForProtocol(),
      if (note != null) 'note': note?.toJsonForProtocol(),
      if (noteId != null) 'noteId': noteId,
      if (actorName != null) 'actorName': actorName,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TodoListEventImpl extends TodoListEvent {
  _TodoListEventImpl({
    required int todoListId,
    required _ixog04aa.TodoEventType eventType,
    _i3rw14gz.TodoItem? todoItem,
    int? todoItemId,
    _if7o0j8k.TodoListMember? member,
    _iwb2uvgt.TodoChatMessage? chatMessage,
    _ihqwc0h0.TodoNote? note,
    int? noteId,
    String? actorName,
    required DateTime timestamp,
  }) : super._(
         todoListId: todoListId,
         eventType: eventType,
         todoItem: todoItem,
         todoItemId: todoItemId,
         member: member,
         chatMessage: chatMessage,
         note: note,
         noteId: noteId,
         actorName: actorName,
         timestamp: timestamp,
       );

  /// Returns a shallow copy of this [TodoListEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  TodoListEvent copyWith({
    int? todoListId,
    _ixog04aa.TodoEventType? eventType,
    Object? todoItem = _Undefined,
    Object? todoItemId = _Undefined,
    Object? member = _Undefined,
    Object? chatMessage = _Undefined,
    Object? note = _Undefined,
    Object? noteId = _Undefined,
    Object? actorName = _Undefined,
    DateTime? timestamp,
  }) {
    return TodoListEvent(
      todoListId: todoListId ?? this.todoListId,
      eventType: eventType ?? this.eventType,
      todoItem: todoItem is _i3rw14gz.TodoItem?
          ? todoItem
          : this.todoItem?.copyWith(),
      todoItemId: todoItemId is int? ? todoItemId : this.todoItemId,
      member: member is _if7o0j8k.TodoListMember?
          ? member
          : this.member?.copyWith(),
      chatMessage: chatMessage is _iwb2uvgt.TodoChatMessage?
          ? chatMessage
          : this.chatMessage?.copyWith(),
      note: note is _ihqwc0h0.TodoNote? ? note : this.note?.copyWith(),
      noteId: noteId is int? ? noteId : this.noteId,
      actorName: actorName is String? ? actorName : this.actorName,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
