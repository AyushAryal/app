class PaginatedBasic {
  int count;
  Uri? next;
  Uri? previous;

  PaginatedBasic({
    required this.count,
    required this.next,
    required this.previous,
  });

  PaginatedBasic.fromJson(Map<String, dynamic> json)
      : count = json["count"] as int,
        next = json["next"] != null ? Uri.parse(json["next"]) : null,
        previous =
            json["previous"] != null ? Uri.parse(json["previous"]) : null;
}

class Paginated<T> {
  int count;
  Uri? next;
  Uri? previous;
  List<T> results;

  Paginated.fromBasic(PaginatedBasic basic, this.results)
      : count = basic.count,
        next = basic.next,
        previous = basic.previous;

  Paginated({
    required this.count,
    required this.results,
    this.next,
    this.previous,
  });
}
