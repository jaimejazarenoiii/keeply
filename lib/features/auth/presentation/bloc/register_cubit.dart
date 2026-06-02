import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:keeply/core/error/api_exception.dart';
import 'package:keeply/core/error/failure.dart';
import 'package:keeply/features/auth/domain/auth_repository.dart';
import 'package:keeply/features/auth/domain/entities/auth_user.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.email = '',
    this.password = '',
    this.name = '',
    this.profileImageUrl = '',
    this.isSubmitting = false,
    this.errorMessage,
    this.user,
  });
  final String email;
  final String password;
  final String name;
  final String profileImageUrl;
  final bool isSubmitting;
  final String? errorMessage;
  final AuthUser? user;
  bool get canSubmit =>
      email.contains('@') &&
      password.isNotEmpty &&
      name.isNotEmpty &&
      !isSubmitting;
  RegisterState copyWith({
    String? email,
    String? password,
    String? name,
    String? profileImageUrl,
    bool? isSubmitting,
    String? errorMessage,
    AuthUser? user,
    bool clearError = false,
  }) => RegisterState(
    email: email ?? this.email,
    password: password ?? this.password,
    name: name ?? this.name,
    profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    isSubmitting: isSubmitting ?? this.isSubmitting,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    user: user ?? this.user,
  );
  @override
  List<Object?> get props => [
    email,
    password,
    name,
    profileImageUrl,
    isSubmitting,
    errorMessage,
    user,
  ];
}

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._repository) : super(const RegisterState());
  final AuthRepository _repository;
  void emailChanged(String value) =>
      emit(state.copyWith(email: value, clearError: true));
  void passwordChanged(String value) =>
      emit(state.copyWith(password: value, clearError: true));
  void nameChanged(String value) =>
      emit(state.copyWith(name: value, clearError: true));
  void profileImageUrlChanged(String value) =>
      emit(state.copyWith(profileImageUrl: value, clearError: true));
  Future<void> submit() async {
    if (!state.canSubmit) return;
    emit(state.copyWith(isSubmitting: true, clearError: true));
    try {
      final session = await _repository.register(
        email: state.email,
        password: state.password,
        name: state.name,
        profileImageUrl: state.profileImageUrl.isEmpty
            ? null
            : state.profileImageUrl,
      );
      emit(state.copyWith(isSubmitting: false, user: session.user));
    } on ApiException catch (error) {
      emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: Failure.fromException(error).message,
        ),
      );
    } on Object {
      emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: 'Unable to create account.',
        ),
      );
    }
  }
}
