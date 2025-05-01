import 'dart:convert';

ResourceRes resourceResFromJson(String str) =>
    ResourceRes.fromJson(json.decode(str));

String resourceResToJson(ResourceRes data) => json.encode(data.toJson());

class ResourceRes {
  String id;
  String url;
  List<String> news;
  List<String> topics;

  ResourceRes({
    required this.id,
    required this.url,
    required this.news,
    required this.topics,
  });

  factory ResourceRes.fromJson(Map<String, dynamic> json) => ResourceRes(
        id: json["_id"],
        url: json["url"],
        news: List<String>.from(json["news"].map((x) => x)),
        topics: List<String>.from(json["topics"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "url": url,
        "news": List<dynamic>.from(news.map((x) => x)),
        "topics": List<dynamic>.from(topics.map((x) => x)),
      };
}
