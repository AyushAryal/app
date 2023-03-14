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
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Colors.green.shade100),
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
                        item.name,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 92, 91, 91),
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(item.user.email),
                    ],
                  ),
                  RatingWidget(
                    rating: item.rating,
                    activeColor: Colors.amber.shade700,
                  ),
                ],
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
              Text(item.description),
            ],
          ),
        ),
        ItemVariantListing(item: item)
      ],
    );
  }
}
