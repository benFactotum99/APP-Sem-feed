class Topic {
  String id;
  String user;
  String name;
  String description;
  bool active;

  Topic({
    required this.id,
    required this.user,
    required this.name,
    required this.description,
    required this.active,
  });

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        id: json["_id"],
        user: json["user"],
        name: json["name"],
        description: json["description"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "name": name,
        "description": description,
        "active": active,
      };
}
