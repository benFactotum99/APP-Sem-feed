import 'dart:convert';

ResourceReq resourceReqFromJson(String str) =>
    ResourceReq.fromJson(json.decode(str));

String resourceReqToJson(ResourceReq data) => json.encode(data.toJson());

class ResourceReq {
  String userId;
  String url;

  ResourceReq({
    required this.userId,
    required this.url,
  });

  factory ResourceReq.fromJson(Map<String, dynamic> json) => ResourceReq(
        userId: json["user_id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "url": url,
      };
}
