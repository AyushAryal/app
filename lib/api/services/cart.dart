import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:app/api/base.dart';
import 'package:app/api/models/cart.dart';

class CartService extends BaseService {
  CartService();
  CartService.from(String server) : super.from(server);

  Future<Cart> get(String token) async {
    final response = await http.get(
      Uri.parse("$server/cart/"),
      headers: getDefaultHeaders(token: token),
    );

    assertGeneralErrors(response);
    final json = Map<String, dynamic>.from(jsonDecode(response.body));
    return Cart.fromJson(json);
  }

  Future<Cart> checkout(String token) async {
    final response = await http.get(
      Uri.parse("$server/cart/checkout/"),
      headers: getDefaultHeaders(token: token),
    );

    assertGeneralErrors(response);
    final json = Map<String, dynamic>.from(jsonDecode(response.body));
    return Cart.fromJson(json);
  }

  Future<Cart> put(String token, CartForm form) async {
    final response = await http.put(
      Uri.parse("$server/cart/"),
      headers: getDefaultHeaders(token: token),
      body: utf8.encode(form.toJson()),
    );
    assertGeneralErrors(response);
    final json = Map<String, dynamic>.from(jsonDecode(response.body));
    return Cart.fromJson(json);
  }

  Future<Cart> addItemVariant(String token, int itemVariantId) async {
    final cart = await get(token);

    final form = cart.getForm();
    form.addItemVariant(itemVariantId);

    return await put(token, form);
  }

  Future<Cart> deleteItemVariant(String token, int itemVariantId) async {
    final cart = await get(token);

    final form = cart.getForm();
    form.deleteItemVariant(itemVariantId);

    return await put(token, form);
  }

  Future<Cart> incrementItemVariant(
    String token,
    int itemVariantId, {
    int value = 1,
  }) async {
    final cart = await get(token);
    final form = cart.getForm();
    form.incrementItem(itemVariantId, value: value);

    return await put(token, form);
  }
}
