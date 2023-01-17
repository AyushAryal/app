import 'package:app/page/profile.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final bool showActions;

  const CustomScaffold(
      {super.key, required this.body, this.showActions = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('FARMERZ'),
        actions: showActions
            ? [
                IconButton(
                    icon: const Icon(Icons.person),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const ProfilePage()),
                      );
                    }),
                const SizedBox(width: 8),
              ]
            : null,
      ),
      body: body,
    );
  }
}
