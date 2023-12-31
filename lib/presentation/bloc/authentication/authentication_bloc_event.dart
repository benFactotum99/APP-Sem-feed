import 'package:sem_feed/data/models/user_req.dart';
import 'package:sem_feed/data/models/user_session.dart';

abstract class AuthenticationBlocEvent {}

class AuthenticationBlocEventAppStarted extends AuthenticationBlocEvent {}

class AuthenticationBlocEventLogin extends AuthenticationBlocEvent {
  final String email;
  final String password;
  AuthenticationBlocEventLogin(this.email, this.password);
}

class AuthenticationBlocEventSignup extends AuthenticationBlocEvent {
  final UserReq userReq;
  AuthenticationBlocEventSignup(this.userReq);
}

class AuthenticationBlocEventLogout extends AuthenticationBlocEvent {}

class AuthenticationBlocEventSaveUserData extends AuthenticationBlocEvent {
  final UserSession userSession;
  AuthenticationBlocEventSaveUserData(this.userSession);
}
