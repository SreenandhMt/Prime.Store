part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class Loading extends AuthState {}

final class Error extends AuthState {
  final String error;

  Error({required this.error});
}

final class Success extends AuthState {
}