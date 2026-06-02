import 'package:keeply/core/error/api_exception.dart';

class Failure {
  const Failure({
    required this.message,
    this.code,
    this.isAuthenticationFailure = false,
  });

  factory Failure.fromException(ApiException exception) {
    final code = exception.error.code;
    final message = switch (code) {
      'INVALID_CREDENTIALS' => 'Email or password is incorrect.',
      'EMAIL_ALREADY_EXISTS' => 'An account already exists for this email.',
      'TOKEN_EXPIRED' ||
      'INVALID_TOKEN' ||
      'SESSION_REVOKED' => 'Your session expired. Please sign in again.',
      'INVALID_MOVE' when exception.error.message.contains('non-empty') =>
        'Move or delete the contents first.',
      _ => exception.error.message,
    };
    return Failure(
      message: message,
      code: code,
      isAuthenticationFailure: exception.error.isTokenRelated,
    );
  }

  final String message;
  final String? code;
  final bool isAuthenticationFailure;
}
