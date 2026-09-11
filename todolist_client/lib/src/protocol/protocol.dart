/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:todolist_client/src/protocol/todos/todo_activity.dart'
    as _i996je9u;
import 'package:todolist_client/src/protocol/todos/todo_chat_message.dart'
    as _igy2qi0p;
import 'package:todolist_client/src/protocol/todos/todo_item.dart' as _iy7cwfj6;
import 'package:todolist_client/src/protocol/todos/todo_list.dart' as _ic5wdmhp;
import 'package:todolist_client/src/protocol/todos/todo_list_member.dart'
    as _i8r85dx0;
import 'package:todolist_client/src/protocol/todos/todo_note.dart' as _iwyd7ghh;
import 'greetings/greeting.dart' as _izw8z7ou;
import 'todos/member_role.dart' as _idi75wb3;
import 'todos/todo_activity.dart' as _i8ma4jb9;
import 'todos/todo_chat_message.dart' as _ilbeygwr;
import 'todos/todo_event_type.dart' as _id2s85jq;
import 'todos/todo_item.dart' as _i2ta30x9;
import 'todos/todo_list.dart' as _i7grl5ge;
import 'todos/todo_list_event.dart' as _iz77c98a;
import 'todos/todo_list_exception.dart' as _igjwrbwp;
import 'todos/todo_list_member.dart' as _ijnkxbpd;
import 'todos/todo_note.dart' as _i8pilih3;
import 'todos/todo_priority.dart' as _iux6ro7o;
import 'todos/user_account_profile.dart' as _ifg1b430;
export 'greetings/greeting.dart';
export 'todos/member_role.dart';
export 'todos/todo_activity.dart';
export 'todos/todo_chat_message.dart';
export 'todos/todo_event_type.dart';
export 'todos/todo_item.dart';
export 'todos/todo_list.dart';
export 'todos/todo_list_event.dart';
export 'todos/todo_list_exception.dart';
export 'todos/todo_list_member.dart';
export 'todos/todo_note.dart';
export 'todos/todo_priority.dart';
export 'todos/user_account_profile.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _izw8z7ou.Greeting) {
      return _izw8z7ou.Greeting.fromJson(data) as T;
    }
    if (t == _idi75wb3.MemberRole) {
      return _idi75wb3.MemberRole.fromJson(data) as T;
    }
    if (t == _i8ma4jb9.TodoActivity) {
      return _i8ma4jb9.TodoActivity.fromJson(data) as T;
    }
    if (t == _ilbeygwr.TodoChatMessage) {
      return _ilbeygwr.TodoChatMessage.fromJson(data) as T;
    }
    if (t == _id2s85jq.TodoEventType) {
      return _id2s85jq.TodoEventType.fromJson(data) as T;
    }
    if (t == _i2ta30x9.TodoItem) {
      return _i2ta30x9.TodoItem.fromJson(data) as T;
    }
    if (t == _i7grl5ge.TodoList) {
      return _i7grl5ge.TodoList.fromJson(data) as T;
    }
    if (t == _iz77c98a.TodoListEvent) {
      return _iz77c98a.TodoListEvent.fromJson(data) as T;
    }
    if (t == _igjwrbwp.TodoListException) {
      return _igjwrbwp.TodoListException.fromJson(data) as T;
    }
    if (t == _ijnkxbpd.TodoListMember) {
      return _ijnkxbpd.TodoListMember.fromJson(data) as T;
    }
    if (t == _i8pilih3.TodoNote) {
      return _i8pilih3.TodoNote.fromJson(data) as T;
    }
    if (t == _iux6ro7o.TodoPriority) {
      return _iux6ro7o.TodoPriority.fromJson(data) as T;
    }
    if (t == _ifg1b430.UserAccountProfile) {
      return _ifg1b430.UserAccountProfile.fromJson(data) as T;
    }
    if (t == _isc.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_idi75wb3.MemberRole?>()) {
      return (data != null ? _idi75wb3.MemberRole.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i8ma4jb9.TodoActivity?>()) {
      return (data != null ? _i8ma4jb9.TodoActivity.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ilbeygwr.TodoChatMessage?>()) {
      return (data != null ? _ilbeygwr.TodoChatMessage.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_id2s85jq.TodoEventType?>()) {
      return (data != null ? _id2s85jq.TodoEventType.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i2ta30x9.TodoItem?>()) {
      return (data != null ? _i2ta30x9.TodoItem.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i7grl5ge.TodoList?>()) {
      return (data != null ? _i7grl5ge.TodoList.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iz77c98a.TodoListEvent?>()) {
      return (data != null ? _iz77c98a.TodoListEvent.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_igjwrbwp.TodoListException?>()) {
      return (data != null ? _igjwrbwp.TodoListException.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ijnkxbpd.TodoListMember?>()) {
      return (data != null ? _ijnkxbpd.TodoListMember.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i8pilih3.TodoNote?>()) {
      return (data != null ? _i8pilih3.TodoNote.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iux6ro7o.TodoPriority?>()) {
      return (data != null ? _iux6ro7o.TodoPriority.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ifg1b430.UserAccountProfile?>()) {
      return (data != null ? _ifg1b430.UserAccountProfile.fromJson(data) : null)
          as T;
    }
    if (t == List<_iy7cwfj6.TodoItem>) {
      return (data as List)
              .map((e) => deserialize<_iy7cwfj6.TodoItem>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i996je9u.TodoActivity>) {
      return (data as List)
              .map((e) => deserialize<_i996je9u.TodoActivity>(e))
              .toList()
          as T;
    }
    if (t == List<_ic5wdmhp.TodoList>) {
      return (data as List)
              .map((e) => deserialize<_ic5wdmhp.TodoList>(e))
              .toList()
          as T;
    }
    if (t == List<_i8r85dx0.TodoListMember>) {
      return (data as List)
              .map((e) => deserialize<_i8r85dx0.TodoListMember>(e))
              .toList()
          as T;
    }
    if (t == List<_igy2qi0p.TodoChatMessage>) {
      return (data as List)
              .map((e) => deserialize<_igy2qi0p.TodoChatMessage>(e))
              .toList()
          as T;
    }
    if (t == List<_iwyd7ghh.TodoNote>) {
      return (data as List)
              .map((e) => deserialize<_iwyd7ghh.TodoNote>(e))
              .toList()
          as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _izw8z7ou.Greeting => 'Greeting',
      _idi75wb3.MemberRole => 'MemberRole',
      _i8ma4jb9.TodoActivity => 'TodoActivity',
      _ilbeygwr.TodoChatMessage => 'TodoChatMessage',
      _id2s85jq.TodoEventType => 'TodoEventType',
      _i2ta30x9.TodoItem => 'TodoItem',
      _i7grl5ge.TodoList => 'TodoList',
      _iz77c98a.TodoListEvent => 'TodoListEvent',
      _igjwrbwp.TodoListException => 'TodoListException',
      _ijnkxbpd.TodoListMember => 'TodoListMember',
      _i8pilih3.TodoNote => 'TodoNote',
      _iux6ro7o.TodoPriority => 'TodoPriority',
      _ifg1b430.UserAccountProfile => 'UserAccountProfile',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('todolist.', '');
    }

    switch (data) {
      case _izw8z7ou.Greeting():
        return 'Greeting';
      case _idi75wb3.MemberRole():
        return 'MemberRole';
      case _i8ma4jb9.TodoActivity():
        return 'TodoActivity';
      case _ilbeygwr.TodoChatMessage():
        return 'TodoChatMessage';
      case _id2s85jq.TodoEventType():
        return 'TodoEventType';
      case _i2ta30x9.TodoItem():
        return 'TodoItem';
      case _i7grl5ge.TodoList():
        return 'TodoList';
      case _iz77c98a.TodoListEvent():
        return 'TodoListEvent';
      case _igjwrbwp.TodoListException():
        return 'TodoListException';
      case _ijnkxbpd.TodoListMember():
        return 'TodoListMember';
      case _i8pilih3.TodoNote():
        return 'TodoNote';
      case _iux6ro7o.TodoPriority():
        return 'TodoPriority';
      case _ifg1b430.UserAccountProfile():
        return 'UserAccountProfile';
    }
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_izw8z7ou.Greeting>(data['data']);
    }
    if (dataClassName == 'MemberRole') {
      return deserialize<_idi75wb3.MemberRole>(data['data']);
    }
    if (dataClassName == 'TodoActivity') {
      return deserialize<_i8ma4jb9.TodoActivity>(data['data']);
    }
    if (dataClassName == 'TodoChatMessage') {
      return deserialize<_ilbeygwr.TodoChatMessage>(data['data']);
    }
    if (dataClassName == 'TodoEventType') {
      return deserialize<_id2s85jq.TodoEventType>(data['data']);
    }
    if (dataClassName == 'TodoItem') {
      return deserialize<_i2ta30x9.TodoItem>(data['data']);
    }
    if (dataClassName == 'TodoList') {
      return deserialize<_i7grl5ge.TodoList>(data['data']);
    }
    if (dataClassName == 'TodoListEvent') {
      return deserialize<_iz77c98a.TodoListEvent>(data['data']);
    }
    if (dataClassName == 'TodoListException') {
      return deserialize<_igjwrbwp.TodoListException>(data['data']);
    }
    if (dataClassName == 'TodoListMember') {
      return deserialize<_ijnkxbpd.TodoListMember>(data['data']);
    }
    if (dataClassName == 'TodoNote') {
      return deserialize<_i8pilih3.TodoNote>(data['data']);
    }
    if (dataClassName == 'TodoPriority') {
      return deserialize<_iux6ro7o.TodoPriority>(data['data']);
    }
    if (dataClassName == 'UserAccountProfile') {
      return deserialize<_ifg1b430.UserAccountProfile>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('todolist', this);
    _iacc.Protocol().registerHostProtocol('todolist', this);
  }

  @override
  String getModuleName() => 'todolist';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
