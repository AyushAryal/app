import 'dart:convert';
import 'dart:math';

import 'package:app/api/models/cart_item.dart';
import 'package:app/api/models/item_variant.dart';
import 'package:flutter/foundation.dart';

class CartFormItem {
  int itemVariant;
  int quantity;

  CartFormItem({required this.itemVariant, required this.quantity});

  String toJson() {
    return '{"item_variant":$itemVariant,"quantity": $quantity}';
  }
}

class CartForm {
  List<CartFormItem> items;

  CartForm(this.items);

  String toJson() {
    final itemsJson = items.map((e) => e.toJson()).join(',');
    return '{"items":[$itemsJson]}';
  }

  addItemVariant(int itemVariant, {int quantity = 1}) {
    int count = items.where((item) => item.itemVariant == itemVariant).length;
    if (count == 0) {
      items.add(CartFormItem(itemVariant: itemVariant, quantity: quantity));
    }
  }

  deleteItemVariant(int itemVariantId) {
    items.removeWhere((cartItem) => cartItem.itemVariant == itemVariantId);
  }

  incrementItem(int itemVariantId, {int value = 1}) {
    for (final cartItem in items) {
      if (cartItem.itemVariant == itemVariantId) {
        cartItem.quantity = max(1, (cartItem.quantity + value));
      }
    }
  }
}

class Cart {
  List<CartItem> items;

  Cart.fromJson(Map<String, dynamic> json)
      : items = (json["items"] as List<dynamic>)
            .map((x) => CartItem.fromJson(x as Map<String, dynamic>))
            .toList();

  CartForm getForm() {
    final cartFormItems = items
        .map((x) =>
            CartFormItem(itemVariant: x.itemVariant, quantity: x.quantity))
        .toList();
    return CartForm(cartFormItems);
  }

  String toJson() {
    return jsonEncode(getForm());
  }
}
