import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intola/src/models/auth/signUpModel.dart';

class SignUpHelper {
  // final baseUrl = "http://localhost:3000/api";
  final baseUrl = "https://intola.herokuapp.com/api";
  Future<Map<String, dynamic>> registerUser({
    required endpoint,
    required fullname,
    required email,
    required password,
  }) async {
    SignUpModel user = SignUpModel(
      fullname: fullname,
      email: email,
      password: password,
    );

    http.Response response = await http.post(
      Uri.parse(baseUrl + endpoint),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(
        user.toJson(),
      ),
    );

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      return responseBody;
    }

    throw response;
  }
}
