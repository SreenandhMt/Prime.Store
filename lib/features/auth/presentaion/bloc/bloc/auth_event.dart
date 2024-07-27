part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class Login extends AuthEvent {
  final String email;
  final String password;

  Login({required this.email, required this.password});
}

final class SignIn extends AuthEvent {
  final String email;
  final String password;
  final String cornformPass;

  SignIn({required this.email, required this.password, required this.cornformPass});
}