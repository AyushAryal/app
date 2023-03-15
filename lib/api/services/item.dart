import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:app/api/base.dart';
import 'package:app/api/models/item.dart';
import 'package:app/api/paginated.dart';

class ItemService extends BaseService {
  ItemService();
  ItemService.from(String server) : super.from(server);

  Future<Item> get({required String token, required int id}) async {
    final response = await http.get(
      Uri.parse("$server/item/$id/"),
      headers: getDefaultHeaders(token: token),
    );
    assertGeneralErrors(response);

    final json = Map<String, dynamic>.from(jsonDecode(response.body));
    return Item.fromJson(json);
  }

  Future<int> getUserRating({required String token, required int id}) async {
    final response = await http.get(
      Uri.parse("$server/item/$id/get_user_rating/"),
      headers: getDefaultHeaders(token: token),
    );
    assertGeneralErrors(response);
    return jsonDecode(response.body) as int;
  }

  Future<List<Item>> recommendations({required String token}) async {
    final response = await http.get(
      Uri.parse("$server/item/recommend"),
      headers: getDefaultHeaders(token: token),
    );
    assertGeneralErrors(response);

    final json = List<int>.from(jsonDecode(response.body));
    List<Item> results = [];
    for (final id in json) {
      results.add(await get(token: token, id: id));
    }
    return results;
  }

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

  setRating(String token, int itemId, int rating) async {
    final response = await http.post(
      Uri.parse("$server/item/$itemId/rating/"),
      headers: getDefaultHeaders(token: token),
      body: utf8.encode("$rating"),
    );
    assertGeneralErrors(response);
  }
}
