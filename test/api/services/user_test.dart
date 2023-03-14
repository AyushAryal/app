import 'package:flutter_test/flutter_test.dart';

import 'package:app/api/models/user.dart';
import 'package:app/api/services/token.dart';
import 'package:app/api/services/user.dart';

import 'utils.dart';

void main() {
  final tokenService = TokenService.from("http://127.0.0.1:8000/api");
  final service = UserService.from("http://127.0.0.1:8000/api");
  test('Get user info', () async {
    final token = await getTokenFor(tokenService, "customer");
    expect(await service.get(token.token), const TypeMatcher<User>());
  });
}
