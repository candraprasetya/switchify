import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switchify/src/blocs/user/user_bloc.dart';
import 'package:switchify/src/services/services.dart';
import 'package:switchify/src/utilities/utilities.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserBloc userBloc;
  RegisterBloc(this.userBloc) : super(RegisterInitial()) {
    on<Register>((event, emit) async {
      emit(RegisterIsLoading());
      final result = await UserService().registerWithEmail(
        email: event.email,
        name: event.username,
        pass: event.password,
      );
      result.fold((l) => emit(RegisterIsFailed(l)), (r) {
        Commons().setUid(r.uid!);
        userBloc.add(FetchUserData());
        emit(RegisterIsSuccess());
      });
    });
  }
}
