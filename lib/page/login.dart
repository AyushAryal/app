import 'package:app/models.dart';
import 'package:app/page/home.dart';
import 'package:flutter/material.dart';
import 'package:app/api/api.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  var hasAttemptedBefore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FractionallySizedBox(
        widthFactor: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(color: Colors.black),
              padding: const EdgeInsets.all(5),
              child: const Text(
                "FARMERZ",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 30),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: TextField(
                controller: usernameController,
                decoration: const InputDecoration(hintText: 'Username'),
                autofocus: true,
                autocorrect: false,
              ),
            ),
            const SizedBox(height: 30),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
                autocorrect: false,
              ),
            ),
            const SizedBox(height: 30),
            hasAttemptedBefore
                ? const Text(
                    'Username/Password was incorrect',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  )
                : const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final token = await API.getToken(
                        username: usernameController.text,
                        password: passwordController.text);
                    if (token == null) {
                      setState(() {
                        hasAttemptedBefore = true;
                      });
                    } else {
                      if (!mounted) return;
                      Provider.of<Token>(context, listen: false)
                          .setToken(token);
                      hasAttemptedBefore = false;
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text('Signup'),
                            content: const Text('To be implemented here.'),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'cancel'),
                                child: const Text('Cancel'),
                              ),
                            ],
                          )),
                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
