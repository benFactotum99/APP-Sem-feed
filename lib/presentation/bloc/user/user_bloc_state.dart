import 'package:sem_feed/data/models/user.dart';

abstract class UserBlocState {}

class UserBlocStateInit extends UserBlocState {}

class UserBlocStateUserLoading extends UserBlocState {}

class UserBlocStateUserLoaded extends UserBlocState {
  final User user;
  UserBlocStateUserLoaded(this.user);
}

class UserBlocStateError extends UserBlocState {
  final String errorMessage;
  UserBlocStateError(this.errorMessage);
}

class UserBlocStateLogout extends UserBlocState {
  final String errorMessage;
  UserBlocStateLogout(this.errorMessage);
}
