class Category {
  final int id;
  final String name;
  final String description;
  final Uri? image;
  final bool recommend;

  Category.fromJson(Map<String, dynamic> data)
      : name = data["name"] as String,
        description = data["description"] as String,
        recommend = data["recommend"] as bool,
        id = data["id"] as int,
        image =
            data["image"] == null ? null : Uri.parse(data["image"] as String);
}
