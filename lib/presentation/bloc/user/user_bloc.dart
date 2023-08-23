import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sem_feed/data/models/user_session.dart';
import 'package:sem_feed/domain/services/user_service.dart';
import 'package:sem_feed/presentation/bloc/user/user_bloc_event.dart';
import 'package:sem_feed/presentation/bloc/user/user_bloc_state.dart';

class UserBloc extends Bloc<UserBlocEvent, UserBlocState> {
  final UserService userService;
  UserBloc({required this.userService}) : super(UserBlocStateInit()) {}

  Future<UserSession?> get currentUser async {
    return userService.currentUser;
  }
}
