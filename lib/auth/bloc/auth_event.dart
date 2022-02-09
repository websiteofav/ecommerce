part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class InitialEvent extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.password, required this.email});
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String mobileNumber;

  RegisterEvent(
      {required this.email,
      required this.password,
      required this.mobileNumber,
      required this.name});
}

class GetAuthUserEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}
