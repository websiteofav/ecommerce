part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  final AuthResponseModel model;
  AuthLoaded({required this.model});
}

class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});
}

class LoginRegisterLoaded extends AuthState {
  final LoginRegisterResponseModel model;
  LoginRegisterLoaded({required this.model});
}

class LogoutLoaded extends AuthState {
  LogoutLoaded();
}
