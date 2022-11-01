part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterIsLoading extends RegisterState {}

class RegisterIsSuccess extends RegisterState {}

class RegisterIsFailed extends RegisterState {
  final String message;

  RegisterIsFailed(this.message);
}
