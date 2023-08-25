import 'dart:convert';

import 'package:sem_feed/data/helpers/custom_api_helper.dart';
import 'package:sem_feed/data/helpers/user_session_helper.dart';
import 'package:http/http.dart' as http;

abstract class MasterApiRepository {
  final String baseUrl;
  final UserSessionHelper userSessionHelper;
  MasterApiRepository(this.baseUrl, this.userSessionHelper);

  Future<Map<String, String>> getHeaderContent() async {
    var currentUser = await userSessionHelper.currentUser;
    if (currentUser == null) throw Exception("Utente non trovato");
    return {'Authorization': 'Bearer ${currentUser.accessToken}'};
  }

  Future<Map<String, String>> getHeaderJsonContent() async {
    var currentUser = await userSessionHelper.currentUser;
    if (currentUser == null) throw Exception("Utente non trovato");
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${currentUser.accessToken}'
    };
  }

  Future<String> genericApiRequest({
    required Map<String, String> headers,
    required String type,
    required String url,
    required dynamic objReq,
  }) async {
    var request = http.Request(type, Uri.parse(url));
    if (objReq != null) request.body = json.encode(objReq.toJson());
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var resp = await response.stream.bytesToString();
      return resp;
    } else if (response.statusCode == 401) {
      await refreshSession();
      return await genericApiRequest(
          headers: headers, type: type, url: url, objReq: objReq);
    } else {
      throw Exception("Errore generico nella richiesta al server");
    }
  }

  Future<void> refreshSession() async {
    var currentUser = await userSessionHelper.currentUser;
    if (currentUser == null) throw Exception("Utente non trovato");
    var accessToken = await CustomApiHelper.getNewAccessToken(
        baseUrl, currentUser.refreshToken);
    currentUser.accessToken = accessToken;
    await userSessionHelper.saveUserSession(currentUser);
  }
}
