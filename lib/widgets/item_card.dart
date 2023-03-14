import 'package:app/widgets/rating.dart';
import 'package:flutter/material.dart';

import 'package:app/api/models/item.dart';
import 'package:app/page/item.dart';
import 'package:app/utils.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final itemCard = ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          item.getTitleImageUri() != null
              ? Image.network(
                  item.getTitleImageUri()!.toString(),
                  height: 250.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  "assets/image_not_found.png",
                  bundle: DefaultAssetBundle.of(context),
                  height: 250.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
          Container(
            decoration: BoxDecoration(color: Colors.black.withAlpha(150)),
            height: 250.0,
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  item.name.toTitleCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  item.user.email,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 5),
                RatingWidget(
                  itemId: item.id,
                  inactiveColor: Colors.white70,
                ),
                Wrap(
                  spacing: 8.0, // gap between adjacent chips
                  runSpacing: 4.0,
                  children: [
                    ...item.categories
                        .map(
                          (x) => Chip(
                            label: Text(
                              x.name,
                              style: const TextStyle(color: Colors.white),
                            ),
                            visualDensity: VisualDensity.compact,
                            backgroundColor: Colors.primaries[
                                    x.name.hashCode % Colors.accents.length]
                                .darken(0.2),
                          ),
                        )
                        .toList(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ItemPage(item: item)),
          );
        },
        child: itemCard);
  }
}
