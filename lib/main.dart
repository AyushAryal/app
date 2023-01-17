import 'package:app/page/home.dart';
import 'package:app/page/login.dart';
import 'package:app/page/product.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:app/models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(ChangeNotifierProvider(
      create: (context) => Token(prefs.getString("token")),
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
      home: Consumer<Token>(builder: (context, token_, child) {
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
