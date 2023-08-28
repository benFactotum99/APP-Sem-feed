import 'dart:convert';

import 'package:sem_feed/data/exceptions/custom_feed_rss_exception.dart';
import 'package:sem_feed/data/helpers/user_session_helper.dart';
import 'package:sem_feed/data/models/news_req.dart';
import 'package:sem_feed/data/models/resource_req.dart';
import 'package:sem_feed/data/models/resource_res.dart';
import 'package:sem_feed/data/repository/api/master_api_repository.dart';

class ResourceRepository extends MasterApiRepository {
  final String baseUrl;
  final UserSessionHelper userSessionHelper;
  ResourceRepository(this.baseUrl, this.userSessionHelper)
      : super(baseUrl, userSessionHelper);

  Future<ResourceRes> create(ResourceReq resourceReq) async {
    var response = await genericApiRequest(
      headers: await getHeaderJsonContent(),
      type: 'POST',
      url: '$baseUrl/Resources/url',
      objReq: resourceReq,
    );
    if (response.statusCode == 201) {
      throw CustomFeedRssException(
          "Nel link inserito non è stato configurato il feed rss, per cui non è consultabile.");
    }
    var resp = await response.stream.bytesToString();
    return ResourceRes.fromJson(jsonDecode(resp));
  }

  Future<void> generateNews(NewsReq newsReq) async {
    var response = await genericApiRequest(
      headers: await getHeaderJsonContent(),
      type: 'POST',
      url: '$baseUrl/News',
      objReq: newsReq,
    );
    await response.stream.bytesToString();
  }
}
