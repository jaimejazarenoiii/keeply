import 'package:dio/dio.dart';
import 'package:keeply/core/error/api_exception.dart';

class ApiClient {
  ApiClient(this.dio);
  final Dio dio;

  Future<T> get<T>(
    String path, {
    required T Function(Object? json) parser,
    Map<String, dynamic>? queryParameters,
  }) => _send('GET', path, parser: parser, queryParameters: queryParameters);
  Future<T> post<T>(
    String path, {
    Object? data,
    required T Function(Object? json) parser,
  }) => _send('POST', path, data: data, parser: parser);
  Future<T> patch<T>(
    String path, {
    Object? data,
    required T Function(Object? json) parser,
  }) => _send('PATCH', path, data: data, parser: parser);
  Future<void> delete(String path) =>
      _send<void>('DELETE', path, parser: (_) {});

  Future<T> _send<T>(
    String method,
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    required T Function(Object? json) parser,
  }) async {
    try {
      final response = await dio.request<Object?>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(method: method),
      );
      if (response.statusCode == 204) return parser(null);
      final body = response.data;
      if (body is Map<String, dynamic> && body.containsKey('data'))
        return parser(body['data']);
      return parser(body);
    } on DioException catch (error) {
      throw _toApiException(error);
    }
  }

  ApiException _toApiException(DioException error) {
    final data = error.response?.data;
    ApiError apiError;
    if (data is Map<String, dynamic> && data['error'] is Map<String, dynamic>) {
      apiError = ApiError.fromJson(data['error'] as Map<String, dynamic>);
    } else {
      apiError = ApiError(
        code: 'INTERNAL_ERROR',
        message: error.message ?? 'Network request failed.',
      );
    }
    return ApiException(
      error: apiError,
      statusCode: error.response?.statusCode,
      requestPath: error.requestOptions.path,
    );
  }
}
