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

abstract class TodoListException
    implements
        _is.SerializableException,
        _is.SerializableModel,
        _is.ProtocolSerialization {
  TodoListException._({
    required this.message,
    required this.statusCode,
  });

  factory TodoListException({
    required String message,
    required int statusCode,
  }) = _TodoListExceptionImpl;

  factory TodoListException.fromJson(Map<String, dynamic> jsonSerialization) {
    return TodoListException(
      message: jsonSerialization['message'] as String,
      statusCode: jsonSerialization['statusCode'] as int,
    );
  }

  String message;

  int statusCode;

  /// Returns a shallow copy of this [TodoListException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  TodoListException copyWith({
    String? message,
    int? statusCode,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TodoListException',
      'message': message,
      'statusCode': statusCode,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TodoListException',
      'message': message,
      'statusCode': statusCode,
    };
  }

  @override
  String toString() {
    return 'TodoListException(message: $message, statusCode: $statusCode)';
  }
}

class _TodoListExceptionImpl extends TodoListException {
  _TodoListExceptionImpl({
    required String message,
    required int statusCode,
  }) : super._(
         message: message,
         statusCode: statusCode,
       );

  /// Returns a shallow copy of this [TodoListException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  TodoListException copyWith({
    String? message,
    int? statusCode,
  }) {
    return TodoListException(
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
    );
  }
}
