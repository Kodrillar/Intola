import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intola/src/features/auth/domain/model/log_in_model.dart';
import 'package:intola/src/features/auth/domain/model/sign_up_model.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/utils/network/request_response.dart';

class AuthNetworkHelper {
  Future<Map<String, dynamic>> loginUser({
    required LogInModel logInModel,
  }) async {
    http.Response response = await http.post(
      Uri.parse(
        API.baseUrl + Endpoints.loginUser,
      ),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(
        logInModel.toJson(),
      ),
    );

    var responseDataBody = RequestResponse.requestResponse(response);
    return responseDataBody;
  }

  Future<Map<String, dynamic>> signUpUser({
    required SignUpModel signUpModel,
  }) async {
    http.Response response = await http.post(
      Uri.parse(
        API.baseUrl + Endpoints.registerUser,
      ),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(
        signUpModel.toJson(),
      ),
    );

    final responseBody = RequestResponse.requestResponse(response);
    return responseBody;
  }
}
