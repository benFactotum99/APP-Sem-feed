// To parse this JSON data, do
//
//     final userSession = userSessionFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserSession userSessionFromJson(String str) =>
    UserSession.fromJson(json.decode(str));

String userSessionToJson(UserSession data) => json.encode(data.toJson());

class UserSession {
  String userId;
  String email;
  String name;
  String surname;
  String accessToken;
  String refreshToken;

  UserSession({
    required this.userId,
    required this.email,
    required this.name,
    required this.surname,
    required this.accessToken,
    required this.refreshToken,
  });

  factory UserSession.fromJson(Map<String, dynamic> json) => UserSession(
        userId: json["userId"],
        email: json["email"],
        name: json["name"],
        surname: json["surname"],
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "email": email,
        "name": name,
        "surname": surname,
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };
}
