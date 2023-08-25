import 'dart:convert';

TopicReq topicReqFromJson(String str) => TopicReq.fromJson(json.decode(str));

String topicReqToJson(TopicReq data) => json.encode(data.toJson());

class TopicReq {
  String user;
  String name;
  String description;
  bool active;

  TopicReq({
    required this.user,
    required this.name,
    required this.description,
    required this.active,
  });

  factory TopicReq.fromJson(Map<String, dynamic> json) => TopicReq(
        user: json["user"],
        name: json["name"],
        description: json["description"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "name": name,
        "description": description,
        "active": active,
      };
}
