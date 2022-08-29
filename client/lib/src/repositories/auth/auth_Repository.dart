import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intola/src/services/auth/log_in_service.dart';
import 'package:http/http.dart';
import 'package:intola/src/services/auth/sign_up_service.dart';
import 'package:intola/src/utils/request_response.dart';

class AuthRepository {
  final LoginHelper _loginHelper = LoginHelper();
  final SignUpHelper _signUpHelper = SignUpHelper();

  Future<Map<String, dynamic>> loginUser(
      {required endpoint, required userEmail, required userPassword}) async {
    return _getRepositoryData(
      getData: () => _loginHelper.loginUser(
        endpoint: endpoint,
        email: userEmail,
        password: userPassword,
      ),
    );
  }

  Future<Map<String, dynamic>> registerUser({
    required endpoint,
    required userFullname,
    required userEmail,
    required userPassword,
  }) {
    return _getRepositoryData(
      getData: () => _signUpHelper.registerUser(
        endpoint: endpoint,
        fullname: userFullname,
        email: userEmail,
        password: userPassword,
      ),
    );
  }

  Future<T> _getRepositoryData<T>(
      {required Future<T> Function() getData}) async {
    try {
      return await getData();
    } on Response catch (response) {
      var responseBody = RequestResponse.requestResponse(response);
      debugPrint(responseBody);
      return jsonDecode(responseBody);

      // rethrow;
    }
  }
}
