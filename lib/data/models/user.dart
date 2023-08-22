import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String id;
  String email;
  String password;
  String name;
  String surname;
  List<String> resources;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.surname,
    required this.resources,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        email: json["email"],
        password: json["password"],
        name: json["name"],
        surname: json["surname"],
        resources: List<String>.from(json["resources"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "password": password,
        "name": name,
        "surname": surname,
        "resources": List<dynamic>.from(resources.map((x) => x)),
      };
}
