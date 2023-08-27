import 'dart:convert';

TokenPayload tokenPayloadFromJson(String str) =>
    TokenPayload.fromJson(json.decode(str));

String tokenPayloadToJson(TokenPayload data) => json.encode(data.toJson());

class TokenPayload {
  String token;

  TokenPayload({
    required this.token,
  });

  factory TokenPayload.fromJson(Map<String, dynamic> json) => TokenPayload(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
