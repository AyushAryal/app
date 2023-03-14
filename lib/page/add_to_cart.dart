import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app/api/models/item_variant.dart';

class AddToCartPage extends StatelessWidget {
  final ItemVariant itemVariant;

  const AddToCartPage({
    required this.itemVariant,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
