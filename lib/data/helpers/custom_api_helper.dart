import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sem_feed/data/exceptions/custom_token_exception.dart';

class CustomApiHelper {
  static Future<String> getNewAccessToken(
      String baseUrl, String refreshToken) async {
    http.StreamedResponse response =
        await apiCallTokenRefresh(baseUrl, refreshToken);

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();

      return jsonDecode(res)['accessToken'];
    } else if (response.statusCode == 403) {
      throw new CustomTokenException(
          "Errore, il token di refresh è scaduto, occorre effettuare il logout.");
    } else {
      throw Exception("Errore generico del server");
    }
  }

  static Future<bool> isTokenValid(String baseUrl, String refreshToken) async {
    http.StreamedResponse response =
        await apiCallTokenRefresh(baseUrl, refreshToken);
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      return false;
    } else {
      throw Exception("Errore ${response.statusCode}");
    }
  }

  static Future<http.StreamedResponse> apiCallTokenRefresh(
      String baseUrl, String refreshToken) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('$baseUrl/Auth/token'));
    request.body = json.encode({"token": refreshToken});
    request.headers.addAll(headers);
    return await request.send();
  }
}
