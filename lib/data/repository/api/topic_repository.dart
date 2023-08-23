import 'dart:convert';
import 'package:sem_feed/data/helpers/user_session_helper.dart';
import 'package:sem_feed/data/models/topic.dart';
import 'package:sem_feed/data/repository/api/master_api_repository.dart';
import 'package:http/http.dart' as http;

class TopicRepository extends MasterApiRepository {
  final String baseUrl;
  final UserSessionHelper userSessionHelper;
  TopicRepository(this.baseUrl, this.userSessionHelper)
      : super(baseUrl, userSessionHelper);

  Future<List<Topic>> getTopics() async {
    var currentUser = await userSessionHelper.currentUser;
    if (currentUser == null) throw Exception("Utente non trovato");

    var headers = {'Authorization': 'Bearer ${currentUser.accessToken}'};
    var request = http.Request(
        'GET', Uri.parse('$baseUrl/Topics/User/${currentUser.userId}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var resp = await response.stream.bytesToString();
      var obj = jsonDecode(resp) as List;
      List<Topic> objList =
          obj.map((tagJson) => Topic.fromJson(tagJson)).toList();
      return objList;
    } else if (response.statusCode == 401) {
      await refreshSession();
      return await getTopics();
    } else {
      throw Exception("Errore nel recupero dei topics");
    }
  }
}
