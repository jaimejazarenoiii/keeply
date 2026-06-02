import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/core/error/api_exception.dart';
import 'package:keeply/core/error/failure.dart';

void main() {
  test('parses API error and maps token failure', () {
    final error = ApiError.fromJson({
      'code': 'TOKEN_EXPIRED',
      'message': 'Expired',
    });
    final failure = Failure.fromException(
      ApiException(error: error, statusCode: 401),
    );

    expect(error.isTokenRelated, isTrue);
    expect(failure.isAuthenticationFailure, isTrue);
    expect(failure.message, contains('session'));
  });
}
