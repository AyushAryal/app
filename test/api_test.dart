import 'package:app/api/api.dart';
import 'package:flutter_test/flutter_test.dart';

Future<String?> getTokenFor(String type) async {
  const userMap = {
    "superuser": {"username": "shark", "password": "123"},
    "customer": {"username": "customer", "password": "shark@123"},
    "merchant": {"username": "merchant", "password": "shark@123"},
    "invalid": {"username": "shark", "password": "shark@123"},
  };
  final username = userMap[type]?["username"];
  final password = userMap[type]?["password"];

  return await API.getToken(username: username!, password: password!);
}

void main() {
  API.server = "http://127.0.0.1:8000/api";
  test('Login to server', () async {
    var token = await getTokenFor("superuser");
    expect(token != null, true);

    token = await getTokenFor("merchant");
    expect(token != null, true);

    token = await getTokenFor("customer");
    expect(token != null, true);

    token = await getTokenFor("invalid");
    expect(token == null, true);
  });

  test("Get token information", () async {
    var token = await getTokenFor("superuser");
    expect(token != null, true);
    API.token = token!;

    final tokenInfo = await API.getTokenInfo();
    expect(tokenInfo != null, true);
    expect(tokenInfo!.user.toString().isNotEmpty, true);
  });

  test("Get User Details", () async {
    var token = await getTokenFor("merchant");
    expect(token != null, true);
    API.token = token!;

    final tokenInfo = await API.getTokenInfo();
    expect(tokenInfo != null, true);
    expect(tokenInfo!.user.toString().isNotEmpty, true);

    final user = await API.getUser(tokenInfo.user);
    expect(user != null, true);
  });

  test("Get Customer Profile", () async {
    var token = await getTokenFor("customer");
    expect(token != null, true);
    API.token = token!;

    final tokenInfo = await API.getTokenInfo();
    expect(tokenInfo != null, true);
    expect(tokenInfo!.user.toString().isNotEmpty, true);

    final user = await API.getUser(tokenInfo.user);
    expect(user != null, true);

    final profileUrl = user!.profile!;
    final profile = await API.getCustomerProfile(profileUrl);
    expect(profile != null, true);
  });

  test("Get Merchant Profile", () async {
    var token = await getTokenFor("merchant");
    expect(token != null, true);
    API.token = token!;

    final tokenInfo = await API.getTokenInfo();
    expect(tokenInfo != null, true);
    expect(tokenInfo!.user.toString().isNotEmpty, true);

    final user = await API.getUser(tokenInfo.user);
    expect(user != null, true);

    final profileUrl = user!.profile!;
    final profile = await API.getMerchantProfile(profileUrl);
    expect(profile != null, true);
  });

  test("List Items", () async {
    testListItemsFor(userType) async {
      var token = await getTokenFor(userType);
      expect(token != null, true);
      API.token = token!;

      var items = await API.listItems();
      expect(items != null, true);
    }

    await testListItemsFor("superuser");
    await testListItemsFor("customer");
    await testListItemsFor("merchant");
  });

  test("Get Item Details", () async {
    var token = await getTokenFor("customer");
    expect(token != null, true);
    API.token = token!;

    var items = await API.listItems();
    expect(items != null, true);

    final itemUrl = items![0].url;
    final item = await API.getItem(itemUrl);
    expect(item != null, true);
  });

  test("Get Invoice list", () async {
    var token = await getTokenFor("customer");
    expect(token != null, true);
    API.token = token!;

    var invoices = await API.listInvoices();
    expect(invoices != null, true);
  });

  test("Get Invoice", () async {
    var token = await getTokenFor("customer");
    expect(token != null, true);
    API.token = token!;

    var invoices = await API.listInvoices();
    expect(invoices != null, true);

    final invoiceUrl = invoices![0].url;
    final invoice = await API.getInvoice(invoiceUrl);
    expect(invoice != null, true);
  });
}
