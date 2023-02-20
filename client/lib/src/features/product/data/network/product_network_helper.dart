import 'package:http/http.dart' as http;
import 'package:intola/src/utils/cache/secure_storage.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/utils/network/request_response.dart';

class ProductNetworkHelper {
  ProductNetworkHelper({required this.secureStorage});
  SecureStorage secureStorage;

  Future<List<dynamic>> getProducts({required String endpointParam}) async {
    final token = await secureStorage.read(key: "token");

    http.Response response = await http.get(
      Uri.parse(API.baseUrl + Endpoints.fetchProducts + endpointParam),
      headers: {
        "accept": "application/json; charset=utf-8",
        "X-auth-token": "$token",
      },
    );

    final responseBody = RequestResponse.requestResponse(response);
    return responseBody;
  }
}
