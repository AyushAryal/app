import 'dart:convert';

class Token {
  final String token;
  final Uri user;

  Token.fromJson(Map<String, dynamic> data)
      : token = data["token"] as String,
        user = Uri.parse(data["user"] as String);

  String toJson() {
    return jsonEncode({"token": token, "user": user.toString()});
  }
}
