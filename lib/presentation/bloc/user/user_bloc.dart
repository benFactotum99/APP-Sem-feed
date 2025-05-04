import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sem_feed/data/exceptions/custom_token_exception.dart';
import 'package:sem_feed/data/models/user_session.dart';
import 'package:sem_feed/application/services/user_service.dart';
import 'package:sem_feed/presentation/bloc/user/user_bloc_event.dart';
import 'package:sem_feed/presentation/bloc/user/user_bloc_state.dart';

class UserBloc extends Bloc<UserBlocEvent, UserBlocState> {
  final UserService userService;
  UserBloc({required this.userService}) : super(UserBlocStateInit()) {
    on<UserBlocEventFetchUser>(
      (event, emit) async {
        try {
          emit(UserBlocStateUserLoading());
          var user = await userService.getUser();
          emit(UserBlocStateUserLoaded(user));
        } on CustomTokenException catch (error) {
          print(error.cause);
          emit(UserBlocStateLogout(error.cause));
        } catch (error) {
          print(error);
          emit(UserBlocStateError(error.toString()));
        }
      },
    );
  }

  Future<UserSession?> get currentUser async {
    return userService.currentUser;
  }
}
