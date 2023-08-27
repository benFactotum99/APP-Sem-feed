import 'dart:convert';

import 'package:sem_feed/data/helpers/user_session_helper.dart';
import 'package:sem_feed/data/models/auth_user_request.dart';
import 'package:sem_feed/data/models/token_payload.dart';
import 'package:sem_feed/data/models/user.dart';
import 'package:sem_feed/data/models/user_session.dart';
import 'package:http/http.dart' as http;
import 'package:sem_feed/data/repository/api/master_api_repository.dart';

class UserRepository extends MasterApiRepository {
  final String baseUrl;
  final UserSessionHelper userSessionHelper;
  UserRepository(this.baseUrl, this.userSessionHelper)
      : super(baseUrl, userSessionHelper);

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

  Future<void> logout() async {
    var user = await userSessionHelper.currentUser;
    if (user == null) throw Exception("Utente non trovato");
    await genericApiRequest(
      headers: {'Content-Type': 'application/json'},
      type: 'POST',
      url: '$baseUrl/Auth/Logout',
      objReq: TokenPayload(token: user.refreshToken),
    );
  }

  Future<User> getUser() async {
    var user = await userSessionHelper.currentUser;
    if (user == null) throw Exception("Utente non trovato");

    var resp = await genericApiRequest(
      headers: {'Authorization': 'Bearer ${user.accessToken}'},
      type: 'GET',
      url: '$baseUrl/Users/${user.userId}',
      objReq: null,
    );
    return User.fromJson(jsonDecode(resp));
  }
}
