import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sem_feed/data/models/user_session.dart';
import 'package:sem_feed/domain/helpers/strings_helper.dart';

class UserSessionHelper {
  final FlutterSecureStorage flutterSecureStorage;
  UserSessionHelper(this.flutterSecureStorage);

  Future<void> saveUserSession(UserSession userSession) async {
    var JsonEncoded = userSession.toJson();
    var json = jsonEncode(JsonEncoded);
    await flutterSecureStorage.write(key: CURRENT_USER, value: json);
  }

  Future<UserSession?> get currentUser async {
    final json = await flutterSecureStorage.read(key: CURRENT_USER);

    if (json != null) {
      final decodedJson = jsonDecode(json);
      return UserSession.fromJson(decodedJson);
    }

    return null;
  }

  Future<void> deleteUserSession() async {
    await flutterSecureStorage.delete(key: CURRENT_USER);
  }
}
