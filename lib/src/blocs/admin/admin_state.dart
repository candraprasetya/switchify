part of 'admin_bloc.dart';

@immutable
abstract class AdminState {}

class AdminInitial extends AdminState {}

class AdminIsLoading extends AdminState {}

class AdminIsSuccess extends AdminState {
  final String message;

  AdminIsSuccess(this.message);
}

class AdminIsFailed extends AdminState {
  final String message;

  AdminIsFailed(this.message);
}
