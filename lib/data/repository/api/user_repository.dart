import 'dart:convert';

import 'package:sem_feed/data/helpers/user_session_helper.dart';
import 'package:sem_feed/data/models/auth_user_request.dart';
import 'package:sem_feed/data/models/user_session.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final String baseUrl;
  final UserSessionHelper userSessionHelper;
  UserRepository(this.baseUrl, this.userSessionHelper);

  Future<UserSession> login(AuthUserRequest authUserRequest) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse('$baseUrl/Auth/Login'));
    request.body = json.encode(authUserRequest.toJson());
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var resp = await response.stream.bytesToString();
      return UserSession.fromJson(jsonDecode(resp));
    } else {
      throw new Exception(response.reasonPhrase);
    }
  }

  Future<void> saveUserSession(UserSession userSession) async {
    await userSessionHelper.saveUserSession(userSession);
  }

  Future<UserSession?> get currentUser async {
    return await userSessionHelper.currentUser;
  }

  Future<void> deleteUserSession() async {
    await userSessionHelper.deleteUserSession();
  }
}
