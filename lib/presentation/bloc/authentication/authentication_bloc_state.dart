import 'package:sem_feed/data/models/user_session.dart';

abstract class AuthenticationBlocState {}

class AuthenticationBlocStateInitialized extends AuthenticationBlocState {}

class AuthenticationBlocStateUnitialized extends AuthenticationBlocState {}

class AuthenticationBlocStateAuthenticated extends AuthenticationBlocState {}

class AuthenticationBlocStateUnauthenticated extends AuthenticationBlocState {}

class AuthenticationBlocStateLoadingAuth extends AuthenticationBlocState {}

class AuthenticationBlocStateLoadingSignup extends AuthenticationBlocState {}

class AuthenticationBlocStateLogout extends AuthenticationBlocState {}

class AuthenticationBlocStateSuccessAuth extends AuthenticationBlocState {
  final UserSession userSession;
  AuthenticationBlocStateSuccessAuth(this.userSession);
}

class AuthenticationBlocStateSuccessSignup extends AuthenticationBlocState {
  final UserSession userSession;
  AuthenticationBlocStateSuccessSignup(this.userSession);
}

class AuthenticationBlocStateErrorAuth extends AuthenticationBlocState {
  String errorMessage;
  AuthenticationBlocStateErrorAuth(this.errorMessage);
}

class AuthenticationBlocStateErrorSignup extends AuthenticationBlocState {
  String errorMessage;
  AuthenticationBlocStateErrorSignup(this.errorMessage);
}
