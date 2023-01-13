import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    const nameField = TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Name",
        isDense: true,
      ),
    );

    const passwordField = TextField(
      obscureText: true,
      decoration: InputDecoration(
        isDense: true,
        border: OutlineInputBorder(),
        labelText: "Password",
      ),
    );

    final submitButton =
        ElevatedButton(onPressed: () => {}, child: const Text("Submit"));

    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Welcome",
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 10.0),
              nameField,
              const SizedBox(height: 8.0),
              passwordField,
              const SizedBox(height: 15.0),
              submitButton,
            ],
          ),
        ),
      ),
    );
  }
}
