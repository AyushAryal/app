import 'package:flutter/material.dart';
import 'package:app/api/models/item.dart';
import 'package:app/widgets/item_variant_card.dart';

class ItemVariantListing extends StatelessWidget {
  final Item item;
  const ItemVariantListing({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> variantCards = [];
    for (final variant in item.itemVariants) {
      variantCards.add(ItemVariantCard(variant: variant));
      variantCards.add(const SizedBox(height: 10));
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20.0),
          Text(
            "${item.itemVariants.length} Variants by vendor",
            style: const TextStyle(
              fontSize: 25,
            ),
          ),
          const SizedBox(height: 20.0),
          ...variantCards,
        ],
      ),
    );
  }
}
