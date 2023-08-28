import 'dart:convert';

ResourceRes resourceResFromJson(String str) =>
    ResourceRes.fromJson(json.decode(str));

String resourceResToJson(ResourceRes data) => json.encode(data.toJson());

class ResourceRes {
  String id;
  String url;
  List<String> newses;
  List<String> topics;

  ResourceRes({
    required this.id,
    required this.url,
    required this.newses,
    required this.topics,
  });

  factory ResourceRes.fromJson(Map<String, dynamic> json) => ResourceRes(
        id: json["_id"],
        url: json["url"],
        newses: List<String>.from(json["newses"].map((x) => x)),
        topics: List<String>.from(json["topics"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "url": url,
        "newses": List<dynamic>.from(newses.map((x) => x)),
        "topics": List<dynamic>.from(topics.map((x) => x)),
      };
}
