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

abstract class TodoNote
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  TodoNote._({
    this.id,
    required this.title,
    required this.content,
    required this.todoListId,
    required this.createdById,
    this.createdByName,
    this.color,
    required this.isPinned,
    required this.createdAt,
    this.updatedAt,
  });

  factory TodoNote({
    int? id,
    required String title,
    required String content,
    required int todoListId,
    required _isc.UuidValue createdById,
    String? createdByName,
    int? color,
    required bool isPinned,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _TodoNoteImpl;

  factory TodoNote.fromJson(Map<String, dynamic> jsonSerialization) {
    return TodoNote(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      content: jsonSerialization['content'] as String,
      todoListId: jsonSerialization['todoListId'] as int,
      createdById: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['createdById'],
      ),
      createdByName: jsonSerialization['createdByName'] as String?,
      color: jsonSerialization['color'] as int?,
      isPinned: _isc.BoolJsonExtension.fromJson(jsonSerialization['isPinned']),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String title;

  String content;

  int todoListId;

  _isc.UuidValue createdById;

  String? createdByName;

  int? color;

  bool isPinned;

  DateTime createdAt;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [TodoNote]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  TodoNote copyWith({
    int? id,
    String? title,
    String? content,
    int? todoListId,
    _isc.UuidValue? createdById,
    String? createdByName,
    int? color,
    bool? isPinned,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TodoNote',
      if (id != null) 'id': id,
      'title': title,
      'content': content,
      'todoListId': todoListId,
      'createdById': createdById.toJson(),
      if (createdByName != null) 'createdByName': createdByName,
      if (color != null) 'color': color,
      'isPinned': isPinned,
      'createdAt': createdAt.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TodoNote',
      if (id != null) 'id': id,
      'title': title,
      'content': content,
      'todoListId': todoListId,
      'createdById': createdById.toJson(),
      if (createdByName != null) 'createdByName': createdByName,
      if (color != null) 'color': color,
      'isPinned': isPinned,
      'createdAt': createdAt.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TodoNoteImpl extends TodoNote {
  _TodoNoteImpl({
    int? id,
    required String title,
    required String content,
    required int todoListId,
    required _isc.UuidValue createdById,
    String? createdByName,
    int? color,
    required bool isPinned,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         title: title,
         content: content,
         todoListId: todoListId,
         createdById: createdById,
         createdByName: createdByName,
         color: color,
         isPinned: isPinned,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [TodoNote]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  TodoNote copyWith({
    Object? id = _Undefined,
    String? title,
    String? content,
    int? todoListId,
    _isc.UuidValue? createdById,
    Object? createdByName = _Undefined,
    Object? color = _Undefined,
    bool? isPinned,
    DateTime? createdAt,
    Object? updatedAt = _Undefined,
  }) {
    return TodoNote(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      todoListId: todoListId ?? this.todoListId,
      createdById: createdById ?? this.createdById,
      createdByName: createdByName is String?
          ? createdByName
          : this.createdByName,
      color: color is int? ? color : this.color,
      isPinned: isPinned ?? this.isPinned,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
