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

abstract class UserAccountProfile
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
    required _isc.UuidValue userId,
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
      userId: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      email: jsonSerialization['email'] as String?,
      displayName: jsonSerialization['displayName'] as String?,
      bio: jsonSerialization['bio'] as String?,
      avatarIndex: jsonSerialization['avatarIndex'] as int?,
      avatarEmoji: jsonSerialization['avatarEmoji'] as String?,
      status: jsonSerialization['status'] as String?,
      themeMode: jsonSerialization['themeMode'] as String?,
      notificationsEnabled: jsonSerialization['notificationsEnabled'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(
              jsonSerialization['notificationsEnabled'],
            ),
      locale: jsonSerialization['locale'] as String?,
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue userId;

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

  /// Returns a shallow copy of this [UserAccountProfile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  UserAccountProfile copyWith({
    int? id,
    _isc.UuidValue? userId,
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserAccountProfileImpl extends UserAccountProfile {
  _UserAccountProfileImpl({
    int? id,
    required _isc.UuidValue userId,
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
  @_isc.useResult
  @override
  UserAccountProfile copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? userId,
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
