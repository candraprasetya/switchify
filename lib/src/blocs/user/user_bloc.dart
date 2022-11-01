import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:switchify/src/models/models.dart';
import 'package:switchify/src/services/services.dart';
import 'package:switchify/src/utilities/utilities.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<FetchUserData>((event, emit) async {
      emit(UserIsLoading());
      final result = await UserService().loadUserData(await Commons().getUid());
      result.fold((l) => emit(UserIsFailed(l)), (r) => emit(UserIsSuccess(r)));
    });
    on<UserLogOut>((event, emit) async {
      await FirebaseAuth.instance.signOut();
      emit(UserIsLoggedOut());
    });
  }
}
