part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class FetchUserData extends UserEvent {}

class UserLogOut extends UserEvent {}
