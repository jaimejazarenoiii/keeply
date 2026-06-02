import 'package:keeply/core/network/api_client.dart';
import 'package:keeply/features/auth/domain/entities/auth_session.dart';
import 'package:keeply/features/auth/domain/entities/auth_user.dart';

class AuthApi {
  AuthApi(this._client);
  final ApiClient _client;

  Future<AuthSession> register({
    required String email,
    required String password,
    required String name,
    String? profileImageUrl,
  }) => _client.post(
    '/auth/register',
    data: {
      'email': email,
      'password': password,
      'name': name,
      if (profileImageUrl != null && profileImageUrl.isNotEmpty)
        'profileImageUrl': profileImageUrl,
    },
    parser: (json) => AuthSession.fromJson(json! as Map<String, dynamic>),
  );
  Future<AuthSession> login({
    required String email,
    required String password,
  }) => _client.post(
    '/auth/login',
    data: {'email': email, 'password': password},
    parser: (json) => AuthSession.fromJson(json! as Map<String, dynamic>),
  );
  Future<AuthSession> refresh(String refreshToken) => _client.post(
    '/auth/refresh',
    data: {'refreshToken': refreshToken},
    parser: (json) => AuthSession.fromJson(json! as Map<String, dynamic>),
  );
  Future<void> logout(String refreshToken) => _client.post(
    '/auth/logout',
    data: {'refreshToken': refreshToken},
    parser: (_) {},
  );
  Future<AuthUser> me() => _client.get(
    '/auth/me',
    parser: (json) => AuthUser.fromJson(json! as Map<String, dynamic>),
  );
}
