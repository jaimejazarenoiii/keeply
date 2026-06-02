import 'package:keeply/core/storage/token_storage.dart';
import 'package:keeply/features/auth/data/auth_api.dart';
import 'package:keeply/features/auth/domain/auth_repository.dart';
import 'package:keeply/features/auth/domain/entities/auth_session.dart';
import 'package:keeply/features/auth/domain/entities/auth_user.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required AuthApi api, required TokenStorage tokenStorage})
    : _api = api,
      _tokenStorage = tokenStorage;
  final AuthApi _api;
  final TokenStorage _tokenStorage;

  @override
  Future<AuthSession> register({
    required String email,
    required String password,
    required String name,
    String? profileImageUrl,
  }) async => _persist(
    await _api.register(
      email: email,
      password: password,
      name: name,
      profileImageUrl: profileImageUrl,
    ),
  );
  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async => _persist(await _api.login(email: email, password: password));
  @override
  Future<AuthSession> refresh() async {
    final token = await _tokenStorage.readRefreshToken();
    if (token == null) throw StateError('No refresh token');
    return _persist(await _api.refresh(token));
  }

  @override
  Future<void> logout() async {
    final token = await _tokenStorage.readRefreshToken();
    if (token != null) {
      try {
        await _api.logout(token);
      } on Object {}
    }
    await _tokenStorage.clear();
  }

  @override
  Future<AuthUser> currentUser() => _api.me();
  @override
  Future<bool> hasStoredSession() async =>
      (await _tokenStorage.readTokens()) != null;
  Future<AuthSession> _persist(AuthSession session) async {
    await _tokenStorage.saveTokens(
      accessToken: session.accessToken,
      refreshToken: session.refreshToken,
    );
    return session;
  }
}
