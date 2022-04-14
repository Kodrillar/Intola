import 'dart:convert';

import 'package:intola/src/services/auth/logInHelper.dart';
import 'package:http/http.dart';
import 'package:intola/src/services/auth/signUpHelper.dart';
import 'package:intola/src/utils/requestResponse.dart';

class AuthRepository {
  LoginHelper _loginHelper = LoginHelper();
  SignUpHelper _signUpHelper = SignUpHelper();

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
      print(responseBody);
      return jsonDecode(responseBody);

      // rethrow;
    }
  }
}
