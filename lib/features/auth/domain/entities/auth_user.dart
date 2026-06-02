import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  const AuthUser({
    required this.id,
    required this.email,
    required this.name,
    this.profileImageUrl,
  });
  factory AuthUser.fromJson(Map<String, dynamic> json) => AuthUser(
    id: json['id'] as String? ?? '',
    email: json['email'] as String? ?? '',
    name: json['name'] as String? ?? '',
    profileImageUrl: json['profileImageUrl'] as String?,
  );
  final String id;
  final String email;
  final String name;
  final String? profileImageUrl;
  @override
  List<Object?> get props => [id, email, name, profileImageUrl];
}
