import 'dart:convert';

import 'package:sem_feed/data/helpers/custom_api_helper.dart';
import 'package:sem_feed/data/helpers/user_session_helper.dart';
import 'package:sem_feed/data/models/news.dart';
import 'package:http/http.dart' as http;
import 'package:sem_feed/data/models/news_req.dart';
import 'package:sem_feed/data/repository/api/master_api_repository.dart';

class NewsRepository extends MasterApiRepository {
  final String baseUrl;
  final UserSessionHelper userSessionHelper;
  NewsRepository(this.baseUrl, this.userSessionHelper)
      : super(baseUrl, userSessionHelper);

  Future<List<News>> getNews() async {
    var currentUser = await userSessionHelper.currentUser;
    if (currentUser == null) throw Exception("Utente non trovato");

    var response = await genericApiRequest(
      headers: {'Authorization': 'Bearer ${currentUser.accessToken}'},
      type: 'GET',
      url: '$baseUrl/News/${currentUser.userId}',
      objReq: null,
    );
    var resp = await response.stream.bytesToString();
    var obj = jsonDecode(resp) as List;
    List<News> objList = obj.map((tagJson) => News.fromJson(tagJson)).toList();
    return objList;
  }
}
