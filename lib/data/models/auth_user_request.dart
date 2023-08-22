import 'dart:convert';

AuthUserRequest authUserRequestFromJson(String str) =>
    AuthUserRequest.fromJson(json.decode(str));

String authUserRequestToJson(AuthUserRequest data) =>
    json.encode(data.toJson());

class AuthUserRequest {
  String email;
  String password;

  AuthUserRequest({
    required this.email,
    required this.password,
  });

  factory AuthUserRequest.fromJson(Map<String, dynamic> json) =>
      AuthUserRequest(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
