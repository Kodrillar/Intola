import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intola/src/exceptions/app_exception.dart';

class RequestResponse {
  static requestResponse(Response response) {
    final responseBody = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        return responseBody;
      case 201:
        return responseBody;
      case 400:
        debugPrint(responseBody.toString());
        throw AppException.badRequestException(responseBody['msg']);
      case 401:
        debugPrint(responseBody.toString());
        throw AppException.unauthorizedRequestException(responseBody['msg']);
      case 404:
        debugPrint(responseBody.toString());
        throw AppException.emptyResourceException(responseBody['msg']);
      case 500:
        throw AppException.serverErrorException(
          'Internal Error! try again shortly.',
        );

      default:
        throw AppException.unhandledResponseCodeException(responseBody['msg']);
    }
  }
}
