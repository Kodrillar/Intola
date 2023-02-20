import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intola/src/features/auth/domain/model/log_in_model.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/utils/network/request_response.dart';

class LoginNetworkHelper {
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
}
