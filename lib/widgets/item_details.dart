import 'package:app/widgets/item_variant_listings.dart';
import 'package:flutter/material.dart';

import 'package:app/api/models/item.dart';

import 'package:app/widgets/rating.dart';
import 'package:app/utils.dart';

class ItemDetails extends StatelessWidget {
  final Item item;
  const ItemDetails({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.elliptical(70, 50),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Colors.green.shade100,
              image: DecorationImage(
                colorFilter:
                    const ColorFilter.mode(Colors.black54, BlendMode.darken),
                image: item.getTitleImageUri() == null
                    ? Image.asset(
                        "assets/1.jpg",
                        bundle: DefaultAssetBundle.of(context),
                      ).image
                    : Image.network(
                        item.getTitleImageUri()!.toString(),
                      ).image,
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name.toTitleCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          item.user.email,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                RatingWidget(
                  itemId: item.id,
                ),
                const SizedBox(height: 10),
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
                const SizedBox(height: 5),
                Text(
                  item.description,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        ItemVariantListing(item: item)
      ],
    );
  }
}
