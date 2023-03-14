import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:app/api/base.dart';
import 'package:app/api/models/item.dart';
import 'package:app/api/paginated.dart';

class ItemService extends BaseService {
  ItemService();
  ItemService.from(String server) : super.from(server);

  Future<Paginated<Item>> list(
      {required String token, Uri? page, String? query}) async {
    final response = await http.get(
      page ?? Uri.parse("$server/item/?search=${query ?? ''}"),
      headers: getDefaultHeaders(token: token),
    );
    assertGeneralErrors(response);

    final json = Map<String, dynamic>.from(jsonDecode(response.body));
    final results = List<dynamic>.from(json["results"])
        .map((e) => Item.fromJson(e as Map<String, dynamic>))
        .toList();
    final ret =
        Paginated<Item>.fromBasic(PaginatedBasic.fromJson(json), results);
    return ret;
  }
}
