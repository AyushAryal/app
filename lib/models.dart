import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/api/models/token.dart';

class TokenProvider extends ChangeNotifier {
  Token? token;

  TokenProvider({this.token});
  Token? getToken() => token;

  void setToken(Token? token) async {
    this.token = token;
    final prefs = await SharedPreferences.getInstance();
    if (token != null) {
      prefs.setString("token", token.token);
    } else {
      prefs.remove("token");
    }
    notifyListeners();
  }
}
