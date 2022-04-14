import 'package:http/http.dart';

class RequestResponse {
  static requestResponse(Response response) {
    switch (response.statusCode) {
      case 400:
        print("This is a BAD Request!");
        print("COMING FROM REQUEST RES ==> ${response.body}");
        return response.body;
      case 401:
        print("This is an UNAUTHORIZED Request!");
        return response.body;
      case 404:
        print("This resource was NOT FOUND!");
        return response.body;
      case 500:
        print("This is a SERVER Error!");
        return response.body;

      default:
        throw response;
    }
  }
}
