class Resource {
  String id;
  String url;

  Resource({
    required this.id,
    required this.url,
  });

  factory Resource.fromJson(Map<String, dynamic> json) => Resource(
        id: json["_id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "url": url,
      };
}
