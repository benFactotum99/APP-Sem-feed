import 'dart:convert';

UserReq userReqFromJson(String str) => UserReq.fromJson(json.decode(str));

String userReqToJson(UserReq data) => json.encode(data.toJson());

class UserReq {
  String email;
  String password;
  String name;
  String surname;

  UserReq({
    required this.email,
    required this.password,
    required this.name,
    required this.surname,
  });

  factory UserReq.fromJson(Map<String, dynamic> json) => UserReq(
        email: json["email"],
        password: json["password"],
        name: json["name"],
        surname: json["surname"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "name": name,
        "surname": surname,
      };
}
