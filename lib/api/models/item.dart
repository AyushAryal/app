import 'dart:math';

import 'package:app/api/models/item_variant.dart';
import 'package:app/api/models/category.dart';
import 'package:app/api/models/user.dart';

class Item {
  final Uri url;
  final User user;
  final String name;
  final String subtitle;
  final String description;
  final bool recommend;
  final double rating;
  final List<Category> categories;
  final List<ItemVariant> itemVariants;

  Item.fromJson(Map<String, dynamic> data)
      : url = Uri.parse(data["url"] as String),
        name = data["name"] as String,
        subtitle = data["subtitle"] as String,
        description = data["description"] as String,
        recommend = data["recommend"] as bool,
        user = User.fromJson(data["user"] as Map<String, dynamic>),
        rating = data["rating"] as double,
        categories = (data["categories"] as List<dynamic>)
            .map((x) => Category.fromJson(x as Map<String, dynamic>))
            .toList(),
        itemVariants = (data["variants"] as List<dynamic>)
            .map((x) => ItemVariant.fromJson(x as Map<String, dynamic>))
            .toList();

  ItemVariant? getVariant(int variantId) {
    for (final variant in itemVariants) {
      if (variant.id == variantId) {
        return variant;
      }
    }
    return null;
  }

  int get id {
    final str = url.path.toString();
    return int.parse(str.substring(str.toString().lastIndexOf('/') + 1));
  }

  Uri? getTitleImageUri() {
    List<Uri> images = [];
    for (final variant in itemVariants) {
      for (final image in variant.images) {
        images.add(image);
      }
    }
    if (images.isEmpty) {
      return null;
    }

    return images[Random().nextInt(images.length)];
  }
}
