import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intola/src/utils/cache/secure_storage.dart';
import 'package:intola/src/utils/network/api.dart';

class ProfileNetworkHelper {
  // final baseUrl = "http://localhost:3000/api";
  final baseUrl = API.baseUrl;
  Future<dynamic> getUser() async {
    final user = await SecureStorage.storage.read(key: 'userName');
    http.Response response = await http.get(
      Uri.parse(baseUrl + endpoints["getUser"]! + '/$user'),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      return responseBody["user"];
    }
    throw response;
  }
}
