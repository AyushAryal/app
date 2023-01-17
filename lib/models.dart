import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/api/api.dart';

class Token extends ChangeNotifier {
  String? _token;

  Token(this._token);
  String? getToken() => _token;

  void setToken(String? token) async {
    _token = token;
    if (token != null) {
      API.token = token;
    } else {
      API.token = "";
    }
    final prefs = await SharedPreferences.getInstance();
    if (token != null) {
      prefs.setString("token", token);
    } else {
      prefs.remove("token");
    }
    notifyListeners();
  }
}
