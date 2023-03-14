import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app/models.dart';
import 'package:app/page/cart.dart';

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
                IconButton(icon: const Icon(Icons.person), onPressed: () {}),
                const SizedBox(width: 8),
                IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartPage(),
                        ),
                      );
                    }),
                IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () {
                      Provider.of<TokenProvider>(context, listen: false)
                          .setToken(null);
                    })
              ]
            : null,
      ),
      body: body,
    );
  }
}
