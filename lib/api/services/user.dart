import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:app/api/base.dart';
import 'package:app/api/models/user.dart';

class UserService extends BaseService {
  UserService.from(String server) : super.from(server);

  Future<User> get(String token) async {
    final response = await http.get(
      Uri.parse("$server/user/"),
      headers: getDefaultHeaders(token: token),
    );

    assertGeneralErrors(response);
    final json = Map<String, dynamic>.from(jsonDecode(response.body));
    return User.fromJson(json);
  }

  getVerificationLink(String token) async {
    final response = await http.get(
      Uri.parse("$server/user/verification_link"),
      headers: getDefaultHeaders(token: token),
    );
    assertGeneralErrors(response);
  }

  changeEmail({
    required String token,
    required int userID,
    required String password,
    required String newEmail,
  }) async {
    final response = await http.post(
      Uri.parse("$server/user/$userID/change_email"),
      headers: getDefaultHeaders(token: token),
      body: utf8.encode(jsonEncode({
        "new_email": newEmail,
        "password": password,
      })),
    );

    assertGeneralErrors(response);
  }

  changePassword({
    required String token,
    required int userID,
    required String password,
    required String newPassword,
  }) async {
    final response = await http.post(
      Uri.parse("$server/user/$userID/change_password"),
      headers: getDefaultHeaders(token: token),
      body: utf8.encode(jsonEncode({
        "new_password": newPassword,
        "password": password,
      })),
    );

    assertGeneralErrors(response);
  }
}
