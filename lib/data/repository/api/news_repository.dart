import 'dart:convert';

import 'package:sem_feed/data/helpers/custom_api_helper.dart';
import 'package:sem_feed/data/helpers/user_session_helper.dart';
import 'package:sem_feed/data/models/news.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  final String baseUrl;
  final UserSessionHelper userSessionHelper;
  NewsRepository(this.baseUrl, this.userSessionHelper);

  Future<List<News>> getNewses() async {
    var currentUser = await userSessionHelper.currentUser;
    if (currentUser == null) throw Exception("Utente non trovato");

    var headers = {'Authorization': 'Bearer ${currentUser.accessToken}'};
    var request =
        http.Request('GET', Uri.parse('$baseUrl/News/${currentUser.userId}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var resp = await response.stream.bytesToString();
      var obj = jsonDecode(resp) as List;
      List<News> objList =
          obj.map((tagJson) => News.fromJson(tagJson)).toList();
      return objList;
    } else if (response.statusCode == 401) {
      var accessToken = await CustomApiHelper.getNewAccessToken(
        baseUrl,
        currentUser.refreshToken,
      );
      currentUser.accessToken = accessToken;
      await userSessionHelper.saveUserSession(currentUser);
      return await getNewses();
    } else {
      throw Exception("Errore nel recupero delle news");
    }
  }
}
