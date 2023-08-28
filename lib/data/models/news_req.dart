// To parse this JSON data, do
//
//     final newsReq = newsReqFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

NewsReq newsReqFromJson(String str) => NewsReq.fromJson(json.decode(str));

String newsReqToJson(NewsReq data) => json.encode(data.toJson());

class NewsReq {
  String resourceId;
  TopicNewsReq topic;

  NewsReq({
    required this.resourceId,
    required this.topic,
  });

  factory NewsReq.fromJson(Map<String, dynamic> json) => NewsReq(
        resourceId: json["resource_id"],
        topic: TopicNewsReq.fromJson(json["topic"]),
      );

  Map<String, dynamic> toJson() => {
        "resource_id": resourceId,
        "topic": topic.toJson(),
      };
}

class TopicNewsReq {
  String id;
  String user;
  String name;
  String description;
  bool active;

  TopicNewsReq({
    required this.id,
    required this.user,
    required this.name,
    required this.description,
    required this.active,
  });

  factory TopicNewsReq.fromJson(Map<String, dynamic> json) => TopicNewsReq(
        id: json["id"],
        user: json["user"],
        name: json["name"],
        description: json["description"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "name": name,
        "description": description,
        "active": active,
      };
}
