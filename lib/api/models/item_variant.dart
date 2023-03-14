class ItemVariant {
  final int id;
  final String color;
  final int stock;
  final int rate;
  final List<Uri> images;

  ItemVariant.fromJson(Map<String, dynamic> data)
      : id = data["id"] as int,
        color = data["color"] as String,
        stock = data["stock"] as int,
        rate = data["rate"] as int,
        images = (data["images"] as List<dynamic>)
            .map((x) => Uri.parse(x as String))
            .toList();
}
