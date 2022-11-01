part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginIsFailed extends LoginState {
  final String message;

  LoginIsFailed(this.message);
}

class LoginIsLoading extends LoginState {}

class LoginIsSuccess extends LoginState {}
