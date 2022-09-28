import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intola/src/utils/cache/secure_storage.dart';
import 'package:intola/src/utils/network/api.dart';

class ProfileNetworkHelper {
  // final baseUrl = "http://localhost:3000/api";
  ProfileNetworkHelper({required this.secureStorage});
  final baseUrl = API.baseUrl;
  final SecureStorage secureStorage;
  Future<dynamic> fetchUserData() async {
    final user = await secureStorage.read(key: 'userName');
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
