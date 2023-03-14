import 'package:app/api/models/item.dart';

class CartItem {
  Item item;
  int quantity;
  int itemVariant;

  CartItem.fromJson(Map<String, dynamic> json)
      : item = Item.fromJson(Map<String, dynamic>.from(json["item"])),
        quantity = json["quantity"] as int,
        itemVariant = json["item_variant"] as int;
}
