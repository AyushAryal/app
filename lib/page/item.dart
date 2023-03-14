import 'package:app/widgets/scaffold.dart';
import 'package:flutter/material.dart';

import 'package:app/api/models/item.dart';
import 'package:app/widgets/item_details.dart';

class ItemPage extends StatelessWidget {
  final Item item;
  const ItemPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: ItemDetails(item: item),
    );
  }
}
