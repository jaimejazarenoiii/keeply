import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:keeply/core/error/api_exception.dart';
import 'package:keeply/core/error/failure.dart';
import 'package:keeply/features/auth/domain/auth_repository.dart';
import 'package:keeply/features/auth/domain/entities/auth_user.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = '',
    this.password = '',
    this.isSubmitting = false,
    this.errorMessage,
    this.user,
  });
  final String email;
  final String password;
  final bool isSubmitting;
  final String? errorMessage;
  final AuthUser? user;
  bool get canSubmit =>
      email.contains('@') && password.isNotEmpty && !isSubmitting;
  LoginState copyWith({
    String? email,
    String? password,
    bool? isSubmitting,
    String? errorMessage,
    AuthUser? user,
    bool clearError = false,
  }) => LoginState(
    email: email ?? this.email,
    password: password ?? this.password,
    isSubmitting: isSubmitting ?? this.isSubmitting,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    user: user ?? this.user,
  );
  @override
  List<Object?> get props => [
    email,
    password,
    isSubmitting,
    errorMessage,
    user,
  ];
}

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._repository) : super(const LoginState());
  final AuthRepository _repository;
  void emailChanged(String value) =>
      emit(state.copyWith(email: value, clearError: true));
  void passwordChanged(String value) =>
      emit(state.copyWith(password: value, clearError: true));
  Future<void> submit() async {
    if (!state.canSubmit) return;
    emit(state.copyWith(isSubmitting: true, clearError: true));
    try {
      final session = await _repository.login(
        email: state.email,
        password: state.password,
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
        state.copyWith(isSubmitting: false, errorMessage: 'Unable to sign in.'),
      );
    }
  }
}
