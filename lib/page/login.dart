import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app/models.dart';
import 'package:app/api/services/token.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var hasAttemptedBefore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
              Colors.black.withAlpha(120),
              BlendMode.multiply,
            ),
            image: Image.asset(
              "assets/login.jpg",
              bundle: DefaultAssetBundle.of(context),
            ).image,
            fit: BoxFit.cover,
          ),
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
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
                style: const TextStyle(color: Colors.white),
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.white),
                ),
                autofocus: true,
                autocorrect: false,
              ),
            ),
            const SizedBox(height: 30),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: passwordController,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.white),
                  hintText: 'Password',
                ),
                obscureText: true,
                autocorrect: false,
              ),
            ),
            const SizedBox(height: 30),
            hasAttemptedBefore
                ? const Text(
                    'Email/Password was incorrect',
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
                    final service = TokenService();
                    final token = service.post(
                      email: emailController.text,
                      password: passwordController.text,
                    );

                    token.then((value) {
                      if (!mounted) return;
                      Provider.of<TokenProvider>(context, listen: false)
                          .setToken(value);
                      hasAttemptedBefore = false;
                    }, onError: (err, _) {
                      setState(() {
                        hasAttemptedBefore = true;
                      });
                    });
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
                      style: TextStyle(fontSize: 20, color: Colors.white),
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
