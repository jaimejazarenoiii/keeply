class ApiError {
  const ApiError({required this.code, required this.message, this.details});

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      code: json['code'] as String? ?? 'INTERNAL_ERROR',
      message: json['message'] as String? ?? 'Something went wrong.',
      details: json['details'] as Map<String, dynamic>?,
    );
  }

  final String code;
  final String message;
  final Map<String, dynamic>? details;

  bool get isTokenRelated => const {
    'AUTHENTICATION_REQUIRED',
    'INVALID_TOKEN',
    'TOKEN_EXPIRED',
    'SESSION_REVOKED',
  }.contains(code);
}

class ApiException implements Exception {
  const ApiException({required this.error, this.statusCode, this.requestPath});

  final ApiError error;
  final int? statusCode;
  final String? requestPath;

  @override
  String toString() => 'ApiException(${error.code}): ${error.message}';
}
