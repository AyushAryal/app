import 'dart:convert';

import 'package:app/api/services/token.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'package:app/models.dart';
import 'package:app/api/models/token.dart';
import 'package:app/page/login.dart';
import 'package:app/page/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("token");
  runApp(ChangeNotifierProvider(
      create: (context) => token == null
          ? TokenProvider()
          : TokenProvider(token: Token.fromJson(jsonDecode(token))),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: Consumer<TokenProvider>(builder: (context, token_, child) {
        final token = token_.getToken();
        if (token == null) {
          return const LoginPage();
        } else {
          return const HomePage();
        }
      }),
    );
  }
}
