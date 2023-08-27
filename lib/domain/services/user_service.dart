import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sem_feed/data/models/auth_user_request.dart';
import 'package:sem_feed/data/models/user.dart';
import 'package:sem_feed/data/models/user_session.dart';
import 'package:sem_feed/data/repository/api/user_repository.dart';

class UserService {
  final UserRepository userRepository;
  UserService(this.userRepository);

  Future<UserSession> login(
    String email,
    String password,
  ) async {
    var userSession = await userRepository.login(
      AuthUserRequest(
        email: email,
        password: password,
      ),
    );
    await userRepository.saveUserSession(userSession);
    return userSession;
  }

  Future<void> signOut() async {
    await userRepository.logout();
    await userRepository.deleteUserSession();
  }

  Future<UserSession?> get currentUser async {
    return userRepository.currentUser;
  }

  Future<User> getUser() async {
    return await userRepository.getUser();
  }
}
