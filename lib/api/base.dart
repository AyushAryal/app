import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:app/api/exceptions.dart';

class BaseService {
  String server = "http://10.0.2.2:8000/api";

  BaseService();
  BaseService.from(this.server);

  Map<String, String> getDefaultHeaders({String token = ""}) {
    if (token.isNotEmpty) {
      return {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token',
      };
    }
    return {'Content-Type': 'application/json'};
  }

  void assertGeneralErrors(http.Response response) {
    if (response.statusCode != 200) {
      final contentType = response.headers["Content-Type"] ?? "";
      if (contentType.contains("application/json")) {
        final json = jsonDecode(response.body);
        if (json["detail"] != null) {
          throw KnownServerError(response.statusCode, json["detail"] as String);
        }
      }
      throw UnknownServerError(response.statusCode);
    }
  }
}
