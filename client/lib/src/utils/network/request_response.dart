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
        debugPrint("This is a BAD Request!");
        debugPrint("COMING FROM REQUEST RES ==> ${response.body}");
        throw BadRequestException(responseBody['msg']);
      case 401:
        debugPrint("This is an UNAUTHORIZED Request!");
        return response.body;
      case 404:
        debugPrint("This resource was NOT FOUND!");
        throw ResourceNotFoundException(responseBody['msg']);
      case 500:
        debugPrint("This is a SERVER Error!");
        return response.body;

      default:
        throw response;
    }
  }
}
