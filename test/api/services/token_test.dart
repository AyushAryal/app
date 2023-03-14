import 'package:flutter_test/flutter_test.dart';

import 'package:app/api/exceptions.dart';
import 'package:app/api/services/token.dart';
import 'package:app/api/models/token.dart';
import 'utils.dart';

void main() {
  final service = TokenService.from("http://127.0.0.1:8000/api");
  test('Login to server', () async {
    expect(await getTokenFor(service, "superuser"), const TypeMatcher<Token>());
    expect(await getTokenFor(service, "customer"), const TypeMatcher<Token>());
    expect(await getTokenFor(service, "merchant"), const TypeMatcher<Token>());
    expect(getTokenFor(service, "invalid"),
        throwsA(const TypeMatcher<UnknownServerError>()));
  });

  test('Get token info from raw token', () async {
    final token = await getTokenFor(service, "superuser");
    expect(await service.get(token.token), const TypeMatcher<Token>());
  });

  test('Revoke token', () async {
    final token = await getTokenFor(service, "superuser");
    await service.delete(token.token);

    final tokenNext = await getTokenFor(service, "superuser");
    expect(token.token, isNot(tokenNext.token));
  });
}
