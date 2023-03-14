import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:app/api/base.dart';
import 'package:app/api/models/token.dart';

class TokenService extends BaseService {
  TokenService();
  TokenService.from(String server) : super.from(server);

  Future<Token> get(String token) async {
    final response = await http.get(
      Uri.parse("$server/token/"),
      headers: getDefaultHeaders(token: token),
    );

    assertGeneralErrors(response);
    final json = Map<String, String>.from(jsonDecode(response.body));
    return Token.fromJson(json);
  }

  delete(String token) async {
    final response = await http.delete(
      Uri.parse("$server/token/"),
      headers: getDefaultHeaders(token: token),
    );
    assertGeneralErrors(response);
  }

  Future<Token> post({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse("$server/token/"),
      headers: getDefaultHeaders(),
      body: utf8.encode(jsonEncode({
        "email": email,
        "password": password,
      })),
    );

    assertGeneralErrors(response);

    final json = Map<String, String>.from(jsonDecode(response.body));
    return Token.fromJson(json);
  }
}
