part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserIsLoading extends UserState {}

class UserIsSuccess extends UserState {
  final UserModel userModel;

  UserIsSuccess(this.userModel);
}

class UserIsLoggedOut extends UserState {}

class UserIsFailed extends UserState {
  final String message;

  UserIsFailed(this.message);
}
