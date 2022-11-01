import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:switchify/src/blocs/blocs.dart';
import 'package:switchify/src/services/services.dart';
import 'package:switchify/src/utilities/utilities.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserBloc userBloc;
  LoginBloc(this.userBloc) : super(LoginInitial()) {
    on<Login>((event, emit) async {
      emit(LoginIsLoading());
      final result = await UserService()
          .loginWithEmail(email: event.email, pass: event.password);
      result.fold((l) => emit(LoginIsFailed(l)), (r) {
        Commons().setUid(r.uid!);
        emit(LoginIsSuccess());
      });
    });
  }
}
