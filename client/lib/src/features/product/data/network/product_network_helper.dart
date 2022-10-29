import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intola/src/utils/cache/secure_storage.dart';
import 'package:intola/src/utils/network/api.dart';

class ProductNetworkHelper {
  ProductNetworkHelper({required this.secureStorage});
  SecureStorage secureStorage;

  Future<List<dynamic>> getProducts({required endpoint}) async {
    final token = await secureStorage.read(key: "token");

    http.Response response = await http.get(
      Uri.parse(API.baseUrl + endpoint),
      headers: {
        "accept": "application/json; charset=utf-8",
        "X-auth-token": "$token",
      },
    );

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      // print(response.body);
      return responseBody;
    }

    throw response;
  }
}
