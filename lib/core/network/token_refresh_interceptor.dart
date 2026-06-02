import 'package:dio/dio.dart';
import 'package:keeply/core/storage/token_storage.dart';

typedef SessionExpiredCallback = void Function();

class TokenRefreshInterceptor extends Interceptor {
  TokenRefreshInterceptor({
    required Dio refreshDio,
    required TokenStorage tokenStorage,
    required SessionExpiredCallback onSessionExpired,
  }) : _refreshDio = refreshDio,
       _tokenStorage = tokenStorage,
       _onSessionExpired = onSessionExpired;

  final Dio _refreshDio;
  final TokenStorage _tokenStorage;
  final SessionExpiredCallback _onSessionExpired;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final data = err.response?.data;
    final code =
        data is Map<String, dynamic> && data['error'] is Map<String, dynamic>
        ? (data['error'] as Map<String, dynamic>)['code'] as String?
        : null;
    final tokenRelated =
        err.response?.statusCode == 401 &&
        const {
          'AUTHENTICATION_REQUIRED',
          'INVALID_TOKEN',
          'TOKEN_EXPIRED',
          'SESSION_REVOKED',
        }.contains(code);
    final alreadyRetried = err.requestOptions.extra['retried'] == true;
    if (!tokenRelated ||
        alreadyRetried ||
        err.requestOptions.extra['skipAuth'] == true)
      return handler.next(err);
    final refreshToken = await _tokenStorage.readRefreshToken();
    if (refreshToken == null) {
      await _tokenStorage.clear();
      _onSessionExpired();
      return handler.next(err);
    }
    try {
      final response = await _refreshDio.post<Map<String, dynamic>>(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
        options: Options(extra: {'skipAuth': true}),
      );
      final data = response.data?['data'] as Map<String, dynamic>?;
      final accessToken = data?['accessToken'] as String?;
      final newRefreshToken = data?['refreshToken'] as String?;
      if (accessToken == null || newRefreshToken == null)
        throw StateError('Invalid refresh response');
      await _tokenStorage.saveTokens(
        accessToken: accessToken,
        refreshToken: newRefreshToken,
      );
      final request = err.requestOptions..extra['retried'] = true;
      request.headers['Authorization'] = 'Bearer $accessToken';
      final retry = await _refreshDio.fetch<Object?>(request);
      return handler.resolve(retry);
    } on Object {
      await _tokenStorage.clear();
      _onSessionExpired();
      return handler.next(err);
    }
  }
}
