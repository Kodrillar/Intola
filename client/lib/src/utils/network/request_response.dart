import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intola/src/exceptions/app_exceptions.dart';

class RequestResponse {
  static requestResponse(Response response) {
    final responseBody = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        return response.body;
      case 400:
        debugPrint(responseBody.toString());
        throw BadRequestException(responseBody['msg']);
      case 401:
        debugPrint(responseBody.toString());
        throw UnauthorizedRequestException();
      case 404:
        debugPrint(responseBody.toString());
        throw ResourceNotFoundException(responseBody['msg']);
      case 500:
        debugPrint(responseBody.toString());
        throw ServerErrorException(
          'Something went wrong, try again shortly...',
        );

      default:
        throw response;
    }
  }
}
