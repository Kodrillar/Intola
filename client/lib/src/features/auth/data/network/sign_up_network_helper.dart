import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intola/src/features/auth/domain/model/sign_up_model.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/utils/network/request_response.dart';

class SignUpNetworkHelper {
  // final baseUrl = "http://localhost:3000/api";

  Future<Map<String, dynamic>> registerUser({
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
      Uri.parse(
        API.baseUrl + Endpoints.registerUser,
      ),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(
        user.toJson(),
      ),
    );

    final responseBody = RequestResponse.requestResponse(response);
    return responseBody;
  }
}
