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

abstract class TodoList
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  TodoList._({
    this.id,
    required this.title,
    this.description,
    required this.color,
    required this.ownerId,
    this.inviteCode,
    required this.createdAt,
    this.updatedAt,
  });

  factory TodoList({
    int? id,
    required String title,
    String? description,
    required int color,
    required _isc.UuidValue ownerId,
    String? inviteCode,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _TodoListImpl;

  factory TodoList.fromJson(Map<String, dynamic> jsonSerialization) {
    return TodoList(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      color: jsonSerialization['color'] as int,
      ownerId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      inviteCode: jsonSerialization['inviteCode'] as String?,
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

  String? description;

  int color;

  _isc.UuidValue ownerId;

  String? inviteCode;

  DateTime createdAt;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [TodoList]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  TodoList copyWith({
    int? id,
    String? title,
    String? description,
    int? color,
    _isc.UuidValue? ownerId,
    String? inviteCode,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TodoList',
      if (id != null) 'id': id,
      'title': title,
      if (description != null) 'description': description,
      'color': color,
      'ownerId': ownerId.toJson(),
      if (inviteCode != null) 'inviteCode': inviteCode,
      'createdAt': createdAt.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TodoList',
      if (id != null) 'id': id,
      'title': title,
      if (description != null) 'description': description,
      'color': color,
      'ownerId': ownerId.toJson(),
      if (inviteCode != null) 'inviteCode': inviteCode,
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

class _TodoListImpl extends TodoList {
  _TodoListImpl({
    int? id,
    required String title,
    String? description,
    required int color,
    required _isc.UuidValue ownerId,
    String? inviteCode,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         title: title,
         description: description,
         color: color,
         ownerId: ownerId,
         inviteCode: inviteCode,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [TodoList]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  TodoList copyWith({
    Object? id = _Undefined,
    String? title,
    Object? description = _Undefined,
    int? color,
    _isc.UuidValue? ownerId,
    Object? inviteCode = _Undefined,
    DateTime? createdAt,
    Object? updatedAt = _Undefined,
  }) {
    return TodoList(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      color: color ?? this.color,
      ownerId: ownerId ?? this.ownerId,
      inviteCode: inviteCode is String? ? inviteCode : this.inviteCode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
