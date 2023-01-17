import 'dart:convert';
import 'package:app/api/api.dart';
import 'package:app/page/product.dart';
import 'package:app/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:app/api/models.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: ListView(
      children: [
        const SizedBox(height: 20),
        FractionallySizedBox(
          widthFactor: 1,
          child: Image.network(
            'https://static.vecteezy.com/system/resources/thumbnails/004/586/902/small/set-of-vegetable-fruit-and-spices-hand-drawn-illustration-healthy-food-drawn-with-line-art-for-material-design-free-vector.jpg',
          ),
        ),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.all(30),
          child: TextField(
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: const BorderSide(
                  width: 3,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              hintText: 'Searching for something?',
              hintStyle: const TextStyle(
                color: Color.fromARGB(255, 171, 166, 166),
              ),
            ),
          ),
        ),
        const ItemListings(),
      ],
    ));
  }
}

class ItemListings extends StatefulWidget {
  const ItemListings({super.key});

  @override
  State<ItemListings> createState() => _ItemListingsState();
}

class _ItemListingsState extends State<ItemListings> {
  late Future<List<Item>?> itemsFuture;

  @override
  void initState() {
    itemsFuture = API.listItems();
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
          for (final item in items) {
            itemWidgetList.add(ItemCard(item: item));
            itemWidgetList.add(const SizedBox(height: 20));
          }

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: const TextSpan(
                        text: 'Check out \nour products',
                        style: TextStyle(
                          color: Color.fromARGB(255, 98, 98, 98),
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      '${items.length} total',
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

class ItemCard extends StatelessWidget {
  final Item item;
  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final itemCard = Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
              "https://img.freepik.com/premium-vector/garlic-vector-hand-drawn-head-garlic-isolated-background_148553-133.jpg"),
          RichText(
            text: TextSpan(
              text: item.name,
              style: const TextStyle(
                color: Color.fromARGB(255, 98, 98, 98),
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );

    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductPage(product: item)),
          );
        },
        child: itemCard);
  }
}
