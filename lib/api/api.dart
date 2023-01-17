import 'dart:convert';

import 'package:app/api/models.dart';
import 'package:http/http.dart' as http;

class API {
  static String server = "http://10.0.2.2:8000/api";
  static String token = "";
  static int statusOk = 200;

  static Map<String, String> getDefaultHeaders() {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Token ${API.token}',
    };
  }

  static Future<String?> getToken({
    required String username,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse("${API.server}/login/"),
      headers: {'Content-Type': 'application/json'},
      body: utf8.encode(jsonEncode({
        "username": username,
        "password": password,
      })),
    );
    if (response.statusCode != API.statusOk) return null;
    final jsonResponse = Map<String, String>.from(jsonDecode(response.body));
    return jsonResponse["token"];
  }

  static Future<TokenInformation?> getTokenInfo() async {
    final response = await http.get(
      Uri.parse("${API.server}/token_info/"),
      headers: API.getDefaultHeaders(),
    );
    if (response.statusCode != API.statusOk) return null;
    return TokenInformation.fromJson(jsonDecode(response.body));
  }

  static Future<User?> getUser(Uri url) async {
    final response = await http.get(url, headers: API.getDefaultHeaders());
    if (response.statusCode != API.statusOk) return null;
    return User.fromJson(jsonDecode(response.body));
  }

  static Future<CustomerProfile?> getCustomerProfile(Uri url) async {
    final response = await http.get(url, headers: API.getDefaultHeaders());
    if (response.statusCode != API.statusOk) return null;
    return CustomerProfile.fromJson(jsonDecode(response.body));
  }

  static Future<MerchantProfile?> getMerchantProfile(Uri url) async {
    final response = await http.get(url, headers: API.getDefaultHeaders());
    if (response.statusCode != API.statusOk) return null;
    return MerchantProfile.fromJson(jsonDecode(response.body));
  }

  static Future<List<Item>?> listItems() async {
    final response = await http.get(Uri.parse("${API.server}/item/"),
        headers: API.getDefaultHeaders());
    if (response.statusCode != API.statusOk) return null;

    var items = <Item>[];
    final itemsRaw = jsonDecode(response.body);
    for (final itemRaw in itemsRaw) {
      final item = Item.fromJson(Map<String, dynamic>.from(itemRaw));
      items.add(item);
    }

    return items;
  }

  static Future<Item?> getItem(Uri url) async {
    final response = await http.get(url, headers: API.getDefaultHeaders());
    if (response.statusCode != API.statusOk) return null;
    return Item.fromJson(jsonDecode(response.body));
  }

  static Future<List<Invoice>?> listInvoices() async {
    final response = await http.get(
      Uri.parse("${API.server}/invoice/"),
      headers: API.getDefaultHeaders(),
    );
    if (response.statusCode != API.statusOk) return null;

    var invoices = <Invoice>[];
    final invoicesRaw = jsonDecode(response.body);
    for (final invoiceRaw in invoicesRaw) {
      invoices.add(Invoice.fromJson(Map<String, dynamic>.from(invoiceRaw)));
    }
    return invoices;
  }

  static Future<Invoice?> getInvoice(Uri url) async {
    final response = await http.get(url, headers: API.getDefaultHeaders());
    if (response.statusCode != API.statusOk) return null;
    return Invoice.fromJson(jsonDecode(response.body));
  }
}
