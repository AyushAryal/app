import 'package:app/api/services/item.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app/api/exceptions.dart';
import 'package:app/api/services/token.dart';
import 'package:app/api/models/token.dart';
import 'utils.dart';

void main() {
  final tokenService = TokenService.from("http://127.0.0.1:8000/api");
  final service = ItemService.from("http://127.0.0.1:8000/api");
  test('Get items', () async {
    final token = await getTokenFor(tokenService, "customer");
    expect(token, const TypeMatcher<Token>());

    final itemPage = await service.list(token: token.token);
  });
}
