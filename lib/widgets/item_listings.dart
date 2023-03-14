import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:app/api/paginated.dart';
import 'package:app/api/models/item.dart';
import 'package:app/api/services/item.dart';
import 'package:app/models.dart';

import 'package:app/widgets/item_card.dart';

class ItemListings extends StatefulWidget {
  const ItemListings({super.key});

  @override
  State<ItemListings> createState() => _ItemListingsState();
}

class _ItemListingsState extends State<ItemListings> {
  late Future<Paginated<Item>> itemsFuture;

  @override
  void initState() {
    final service = ItemService();

    final token = Provider.of<TokenProvider>(context, listen: false).getToken();
    if (token != null) {
      itemsFuture = service.list(token: token.token);
    } else {
      itemsFuture = Future.error("");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          final items = snapshot.data!;
          var itemWidgetList = <Widget>[];
          for (final item in items.results) {
            itemWidgetList.add(ItemCard(item: item));
            itemWidgetList.add(const SizedBox(height: 20));
          }

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Check out our \nproducts',
                      style: TextStyle(
                        color: Color.fromARGB(255, 98, 98, 98),
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${items.count} total',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 113, 113, 113),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
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
