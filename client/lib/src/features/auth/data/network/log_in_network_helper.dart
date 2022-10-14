import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intola/src/features/auth/domain/model/log_in_model.dart';
import 'package:intola/src/utils/network/request_response.dart';

class LoginNetworkHelper {
  // final baseUrl = "http://localhost:3000/api";
  final baseUrl = "https://intola.herokuapp.com/api";
  Future<Map<String, dynamic>> loginUser(
      {required endpoint, required email, required password}) async {
    LogInModel _logInModel = LogInModel(
      email: email,
      password: password,
    );

    http.Response response = await http.post(
      // use API.getRequestUrl(path: endpoints["loginUser"]!) when server is deployed
      Uri.parse(baseUrl + endpoint),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(
        _logInModel.toJson(),
      ),
    );

    var responseDataBody = RequestResponse.requestResponse(response);
    return jsonDecode(responseDataBody);
  }
}
