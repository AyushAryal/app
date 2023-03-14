import 'package:flutter/material.dart';

import 'package:app/widgets/scaffold.dart';
import 'package:app/widgets/item_listings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: ListView(
      children: const [
        ItemListings(),
      ],
    ));
  }
}
