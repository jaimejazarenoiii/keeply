import 'package:keeply/features/auth/domain/entities/auth_session.dart';
import 'package:keeply/features/auth/domain/entities/auth_user.dart';

abstract class AuthRepository {
  Future<AuthSession> register({
    required String email,
    required String password,
    required String name,
    String? profileImageUrl,
  });
  Future<AuthSession> login({required String email, required String password});
  Future<AuthSession> refresh();
  Future<void> logout();
  Future<AuthUser> currentUser();
  Future<bool> hasStoredSession();
}
