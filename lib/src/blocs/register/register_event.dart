part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class Register extends RegisterEvent {
  final String username;
  final String email;
  final String password;

  Register(this.username, this.email, this.password);
}
