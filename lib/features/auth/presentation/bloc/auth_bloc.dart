import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:keeply/features/auth/domain/auth_repository.dart';
import 'package:keeply/features/auth/domain/entities/auth_user.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class AuthStarted extends AuthEvent {
  const AuthStarted();
}

class AuthSessionChanged extends AuthEvent {
  const AuthSessionChanged(this.user);
  final AuthUser user;
  @override
  List<Object?> get props => [user];
}

class AuthSessionExpired extends AuthEvent {
  const AuthSessionExpired();
}

class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

sealed class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthUnknown extends AuthState {
  const AuthUnknown();
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthAuthenticated extends AuthState {
  const AuthAuthenticated(this.user);
  final AuthUser user;
  @override
  List<Object?> get props => [user];
}

class AuthFailure extends AuthState {
  const AuthFailure(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._repository) : super(const AuthUnknown()) {
    on<AuthStarted>(_onStarted);
    on<AuthSessionChanged>(
      (event, emit) => emit(AuthAuthenticated(event.user)),
    );
    on<AuthSessionExpired>((event, emit) => emit(const AuthUnauthenticated()));
    on<AuthLogoutRequested>(_onLogout);
  }
  final AuthRepository _repository;
  Future<void> _onStarted(AuthStarted event, Emitter<AuthState> emit) async {
    emit(const AuthUnknown());
    try {
      if (!await _repository.hasStoredSession())
        return emit(const AuthUnauthenticated());
      emit(AuthAuthenticated(await _repository.currentUser()));
    } on Object {
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onLogout(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _repository.logout();
    emit(const AuthUnauthenticated());
  }
}
