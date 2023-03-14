import 'package:flutter_test/flutter_test.dart';

import 'package:app/api/exceptions.dart';
import 'package:app/api/services/cart.dart';
import 'package:app/api/services/token.dart';
import 'package:app/api/models/cart.dart';
import 'utils.dart';

void main() {
  final tokenService = TokenService.from("http://127.0.0.1:8000/api");
  final service = CartService.from("http://127.0.0.1:8000/api");
  test('Get Cart', () async {
    final token = await getTokenFor(tokenService, "customer");
    expect(await service.get(token.token), const TypeMatcher<Cart>());

    final cart = await service.get(token.token);
    expect(cart.items.isNotEmpty, true);

    final cartItem = cart.items.first;
    expect(cartItem.item.name.isNotEmpty, true);
  });
}
