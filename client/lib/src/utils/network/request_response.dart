import 'package:flutter/material.dart';
import 'package:http/http.dart';

class RequestResponse {
  static requestResponse(Response response) {
    switch (response.statusCode) {
      case 400:
        debugPrint("This is a BAD Request!");
        debugPrint("COMING FROM REQUEST RES ==> ${response.body}");
        return response.body;
      case 401:
        debugPrint("This is an UNAUTHORIZED Request!");
        return response.body;
      case 404:
        debugPrint("This resource was NOT FOUND!");
        return response.body;
      case 500:
        debugPrint("This is a SERVER Error!");
        return response.body;

      default:
        throw response;
    }
  }
}
