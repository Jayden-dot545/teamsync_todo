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

enum TodoEventType implements _is.SerializableModel {
  itemCreated,
  itemUpdated,
  itemDeleted,
  listUpdated,
  listDeleted,
  memberJoined,
  memberRemoved,
  chatMessageSent,
  noteCreated,
  noteUpdated,
  noteDeleted;

  static TodoEventType fromJson(String name) {
    switch (name) {
      case 'itemCreated':
        return TodoEventType.itemCreated;
      case 'itemUpdated':
        return TodoEventType.itemUpdated;
      case 'itemDeleted':
        return TodoEventType.itemDeleted;
      case 'listUpdated':
        return TodoEventType.listUpdated;
      case 'listDeleted':
        return TodoEventType.listDeleted;
      case 'memberJoined':
        return TodoEventType.memberJoined;
      case 'memberRemoved':
        return TodoEventType.memberRemoved;
      case 'chatMessageSent':
        return TodoEventType.chatMessageSent;
      case 'noteCreated':
        return TodoEventType.noteCreated;
      case 'noteUpdated':
        return TodoEventType.noteUpdated;
      case 'noteDeleted':
        return TodoEventType.noteDeleted;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "TodoEventType"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
