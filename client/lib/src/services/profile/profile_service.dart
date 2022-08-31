import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intola/src/utils/network/api.dart';

class ProfileService {
  // final baseUrl = "http://localhost:3000/api";
  final baseUrl = API.baseUrl;
  Future<dynamic> getUser({required endpoint}) async {
    http.Response response = await http.get(
      Uri.parse(baseUrl + endpoint),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      return responseBody["user"];
    }
    throw response;
  }
}
