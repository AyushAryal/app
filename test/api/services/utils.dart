import 'package:app/api/services/token.dart';
import 'package:app/api/models/token.dart';

Future<Token> getTokenFor(TokenService service, String type) async {
  const userMap = {
    "superuser": {"email": "admin@example.com", "password": "shark@123"},
    "customer": {"email": "customer@example.com", "password": "shark@123"},
    "customer1": {"email": "customer1@example.com", "password": "shark@123"},
    "merchant": {"email": "merchant@example.com", "password": "shark@123"},
    "invalid": {"email": "shark", "password": "shark@123"},
  };
  final email = userMap[type]?["email"];
  final password = userMap[type]?["password"];
  return await service.post(email: email!, password: password!);
}
