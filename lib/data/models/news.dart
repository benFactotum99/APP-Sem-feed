import 'dart:convert';
import 'package:sem_feed/data/models/resource.dart';
import 'package:sem_feed/data/models/topic_wrap.dart';

News newsFromJson(String str) => News.fromJson(json.decode(str));

String newsToJson(News data) => json.encode(data.toJson());

class News {
  String id;
  String content;
  String contentSnippet;
  String guid;
  String link;
  String pubDate;
  Resource resource;
  String title;
  List<TopicWrap> topics;

  News({
    required this.id,
    required this.content,
    required this.contentSnippet,
    required this.guid,
    required this.link,
    required this.pubDate,
    required this.resource,
    required this.title,
    required this.topics,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
        id: json["_id"],
        content: json["content"],
        contentSnippet: json["contentSnippet"],
        guid: json["guid"],
        link: json["link"],
        pubDate: json["pubDate"],
        resource: Resource.fromJson(json["resource"]),
        title: json["title"],
        topics: List<TopicWrap>.from(
            json["topics"].map((x) => TopicWrap.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "content": content,
        "contentSnippet": contentSnippet,
        "guid": guid,
        "link": link,
        "pubDate": pubDate,
        "resource": resource.toJson(),
        "title": title,
        "topics": List<dynamic>.from(topics.map((x) => x.toJson())),
      };
}
