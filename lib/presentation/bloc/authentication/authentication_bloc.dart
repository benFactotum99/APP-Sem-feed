import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sem_feed/data/models/auth_user_request.dart';
import 'package:sem_feed/application/helpers/strings_helper.dart';
import 'package:sem_feed/application/services/user_service.dart';
import 'package:sem_feed/presentation/bloc/authentication/authentication_bloc_event.dart';
import 'package:sem_feed/presentation/bloc/authentication/authentication_bloc_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationBlocEvent, AuthenticationBlocState> {
  final UserService userService;

  AuthenticationBloc({required this.userService})
      : super(AuthenticationBlocStateInitialized()) {
    on<AuthenticationBlocEventLogout>((event, emit) async {
      try {
        await userService.signOut();
        emit(AuthenticationBlocStateLogout());
      } catch (error) {
        print(error);
        emit(AuthenticationBlocStateUnauthenticated());
      }
    });

    on<AuthenticationBlocEventLogin>((event, emit) async {
      try {
        emit(AuthenticationBlocStateLoadingAuth());
        var userResponse = await userService.login(
          event.email,
          event.password,
        );
        emit(AuthenticationBlocStateSuccessAuth(userResponse));
      } catch (error) {
        String errorMessage;
        switch (error) {
          case "user-not-found":
            errorMessage = "Non esiste un utente con questa email.";
            break;
          case "wrong-password":
            errorMessage = "Password errata.";
            break;
          case "generic-error":
            errorMessage = "Errore generico.";
            break;
          case "internal-server-error":
            errorMessage =
                "Errore sul server si prega di contattare gli amministratori del sistema.";
            break;
          default:
            errorMessage = "Errore non definito.";
        }
        emit(AuthenticationBlocStateErrorAuth(errorMessage));
      }
    });

    on<AuthenticationBlocEventSignup>((event, emit) async {
      try {
        emit(AuthenticationBlocStateLoadingSignup());
        var userResponse = await userService.register(event.userReq);
        emit(AuthenticationBlocStateSuccessSignup(userResponse));
      } catch (error) {
        String errorMessage;
        switch (error) {
          case "user-not-found":
            errorMessage = "Non esiste un utente con questa email.";
            break;
          case "wrong-password":
            errorMessage = "Password errata.";
            break;
          case "generic-error":
            errorMessage = "Errore generico.";
            break;
          case "internal-server-error":
            errorMessage =
                "Errore sul server si prega di contattare gli amministratori del sistema.";
            break;
          default:
            errorMessage = "Errore non definito.";
        }
        emit(AuthenticationBlocStateErrorSignup(errorMessage));
      }
    });
  }
}
