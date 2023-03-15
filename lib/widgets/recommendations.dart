import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:app/api/paginated.dart';
import 'package:app/api/models/item.dart';
import 'package:app/api/services/item.dart';
import 'package:app/models.dart';

import 'package:app/widgets/item_card.dart';

class Recommendations extends StatefulWidget {
  const Recommendations({super.key});

  @override
  State<Recommendations> createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  late Future<List<Item>> itemsFuture;

  @override
  void initState() {
    final service = ItemService();

    final token =
        Provider.of<TokenProvider>(context, listen: false).getToken()!;
    itemsFuture = service.recommendations(token: token.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final service = ItemService();
    final token =
        Provider.of<TokenProvider>(context, listen: false).getToken()!;

    return FutureBuilder(
      future: itemsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          final items = snapshot.data!;
          var itemWidgetList = <Widget>[];
          for (final item in items) {
            itemWidgetList.add(ItemCard(item: item));
            itemWidgetList.add(const SizedBox(height: 20));
          }

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Recommendations",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: 15),
                ...itemWidgetList,
              ],
            ),
          );
        } else {
          return const FractionallySizedBox(
            widthFactor: 0.25,
            child: AspectRatio(
              aspectRatio: 1,
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
