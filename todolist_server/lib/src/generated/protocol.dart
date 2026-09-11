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
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'package:todolist_server/src/generated/todos/todo_activity.dart'
    as _izoaewnk;
import 'package:todolist_server/src/generated/todos/todo_chat_message.dart'
    as _i0csnog7;
import 'package:todolist_server/src/generated/todos/todo_item.dart'
    as _iv9017kb;
import 'package:todolist_server/src/generated/todos/todo_list.dart'
    as _ioyoi3mj;
import 'package:todolist_server/src/generated/todos/todo_list_member.dart'
    as _igz9noqx;
import 'package:todolist_server/src/generated/todos/todo_note.dart'
    as _ikjgv09i;
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

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'todo_activity',
      dartName: 'TodoActivity',
      schema: 'public',
      module: 'todolist',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'todoListId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'actorUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'actorName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'actionType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'details',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'targetTitle',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'timestamp',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'todo_activity_fk_0',
          columns: ['todoListId'],
          referenceTable: 'todo_list',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'todo_activity_list_time_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'todoListId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'timestamp',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'todo_chat_message',
      dartName: 'TodoChatMessage',
      schema: 'public',
      module: 'todolist',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'todoListId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'senderUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'senderName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'senderRole',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:MemberRole',
        ),
        _isp.ColumnDefinition(
          name: 'recipientUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'recipientName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'isPrivate',
          columnType: _isp.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _isp.ColumnDefinition(
          name: 'message',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'sentAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'todo_chat_message_fk_0',
          columns: ['todoListId'],
          referenceTable: 'todo_list',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'todo_chat_message_list_time_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'todoListId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'sentAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'todo_item',
      dartName: 'TodoItem',
      schema: 'public',
      module: 'todolist',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'todoListId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'isCompleted',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'completedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'completedByUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'completedByName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'dueDate',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'priority',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:TodoPriority',
        ),
        _isp.ColumnDefinition(
          name: 'assignedToUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'assignedToName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'createdById',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'createdByName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'sortOrder',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'totalDurationSeconds',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'timerStartedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'isTimerRunning',
          columnType: _isp.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _isp.ColumnDefinition(
          name: 'timerUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'timerUserName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'subtasksJson',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'workSessionsJson',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'recurrence',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'todo_item_fk_0',
          columns: ['todoListId'],
          referenceTable: 'todo_list',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'todo_item_list_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'todoListId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'todo_list',
      dartName: 'TodoList',
      schema: 'public',
      module: 'todolist',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'color',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'ownerId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'inviteCode',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'todo_list_invite_code_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'inviteCode',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'todo_list_member',
      dartName: 'TodoListMember',
      schema: 'public',
      module: 'todolist',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'todoListId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'userEmail',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'userName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'userBio',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'userAvatar',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'userStatus',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'role',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:MemberRole',
        ),
        _isp.ColumnDefinition(
          name: 'joinedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'todo_list_member_fk_0',
          columns: ['todoListId'],
          referenceTable: 'todo_list',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'todo_list_member_list_email_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'todoListId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userEmail',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'todo_note',
      dartName: 'TodoNote',
      schema: 'public',
      module: 'todolist',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'content',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'todoListId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'createdById',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'createdByName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'color',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'isPinned',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'todo_note_list_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'todoListId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'user_account_profile',
      dartName: 'UserAccountProfile',
      schema: 'public',
      module: 'todolist',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'email',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'displayName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'bio',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'avatarIndex',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'avatarEmoji',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'themeMode',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'notificationsEnabled',
          columnType: _isp.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _isp.ColumnDefinition(
          name: 'locale',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'user_account_profile_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._iais.Protocol.targetTableDefinitions,
    ..._iacs.Protocol.targetTableDefinitions,
    ..._isp.Protocol.targetTableDefinitions,
  ];

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
      } on _is.DeserializationClassNameNotFoundException catch (_) {
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
    if (t == _is.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_idi75wb3.MemberRole?>()) {
      return (data != null ? _idi75wb3.MemberRole.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i8ma4jb9.TodoActivity?>()) {
      return (data != null ? _i8ma4jb9.TodoActivity.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ilbeygwr.TodoChatMessage?>()) {
      return (data != null ? _ilbeygwr.TodoChatMessage.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_id2s85jq.TodoEventType?>()) {
      return (data != null ? _id2s85jq.TodoEventType.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i2ta30x9.TodoItem?>()) {
      return (data != null ? _i2ta30x9.TodoItem.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i7grl5ge.TodoList?>()) {
      return (data != null ? _i7grl5ge.TodoList.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iz77c98a.TodoListEvent?>()) {
      return (data != null ? _iz77c98a.TodoListEvent.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_igjwrbwp.TodoListException?>()) {
      return (data != null ? _igjwrbwp.TodoListException.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ijnkxbpd.TodoListMember?>()) {
      return (data != null ? _ijnkxbpd.TodoListMember.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i8pilih3.TodoNote?>()) {
      return (data != null ? _i8pilih3.TodoNote.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iux6ro7o.TodoPriority?>()) {
      return (data != null ? _iux6ro7o.TodoPriority.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ifg1b430.UserAccountProfile?>()) {
      return (data != null ? _ifg1b430.UserAccountProfile.fromJson(data) : null)
          as T;
    }
    if (t == List<_iv9017kb.TodoItem>) {
      return (data as List)
              .map((e) => deserialize<_iv9017kb.TodoItem>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_izoaewnk.TodoActivity>) {
      return (data as List)
              .map((e) => deserialize<_izoaewnk.TodoActivity>(e))
              .toList()
          as T;
    }
    if (t == List<_ioyoi3mj.TodoList>) {
      return (data as List)
              .map((e) => deserialize<_ioyoi3mj.TodoList>(e))
              .toList()
          as T;
    }
    if (t == List<_igz9noqx.TodoListMember>) {
      return (data as List)
              .map((e) => deserialize<_igz9noqx.TodoListMember>(e))
              .toList()
          as T;
    }
    if (t == List<_i0csnog7.TodoChatMessage>) {
      return (data as List)
              .map((e) => deserialize<_i0csnog7.TodoChatMessage>(e))
              .toList()
          as T;
    }
    if (t == List<_ikjgv09i.TodoNote>) {
      return (data as List)
              .map((e) => deserialize<_ikjgv09i.TodoNote>(e))
              .toList()
          as T;
    }
    try {
      return _iais.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacs.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
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
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
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
      return _iais.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacs.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iais.Protocol().registerHostProtocol('todolist', this);
    _iacs.Protocol().registerHostProtocol('todolist', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i8ma4jb9.TodoActivity:
        return _i8ma4jb9.TodoActivity.t;
      case _ilbeygwr.TodoChatMessage:
        return _ilbeygwr.TodoChatMessage.t;
      case _i2ta30x9.TodoItem:
        return _i2ta30x9.TodoItem.t;
      case _i7grl5ge.TodoList:
        return _i7grl5ge.TodoList.t;
      case _ijnkxbpd.TodoListMember:
        return _ijnkxbpd.TodoListMember.t;
      case _i8pilih3.TodoNote:
        return _i8pilih3.TodoNote.t;
      case _ifg1b430.UserAccountProfile:
        return _ifg1b430.UserAccountProfile.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

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
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
