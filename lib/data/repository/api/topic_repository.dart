import 'dart:convert';
import 'package:sem_feed/data/helpers/user_session_helper.dart';
import 'package:sem_feed/data/models/topic.dart';
import 'package:sem_feed/data/models/topic_req.dart';
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

    var resp = await genericApiRequest(
      headers: {'Authorization': 'Bearer ${currentUser.accessToken}'},
      type: 'GET',
      url: '$baseUrl/Topics/User/${currentUser.userId}',
      objReq: null,
    );
    var obj = jsonDecode(resp) as List;
    List<Topic> objList =
        obj.map((tagJson) => Topic.fromJson(tagJson)).toList();
    return objList;
  }

  Future<Topic> create(TopicReq topicReq) async {
    var resp = await genericApiRequest(
      headers: await getHeaderJsonContent(),
      type: 'POST',
      url: '$baseUrl/Topics',
      objReq: topicReq,
    );
    return Topic.fromJson(jsonDecode(resp));
  }

  Future<Topic> update(Topic topic) async {
    var resp = await genericApiRequest(
      headers: await getHeaderJsonContent(),
      type: 'PUT',
      url: '$baseUrl/Topics',
      objReq: topic,
    );
    return Topic.fromJson(jsonDecode(resp));
  }

  Future<void> delete(String topicsId) async {
    await genericApiRequest(
      headers: await getHeaderJsonContent(),
      type: 'DELETE',
      url: '$baseUrl/Topics/${topicsId}',
      objReq: null,
    );
  }
}
