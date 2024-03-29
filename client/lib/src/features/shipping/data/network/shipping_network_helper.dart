import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intola/src/features/shipping/domain/model/shipping_model.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/utils/network/request_response.dart';

class ShippingNetworkHelper {
  // final baseUrl = "http://localhost:3000/api";
  ShippingNetworkHelper({required this.secureStorage});
  final baseUrl = API.baseUrl;
  final SecureStorage secureStorage;

  Future<void> addShippingAddress(
      {required ShippingModel shippingModel}) async {
    final token = secureStorage.read(key: "token");
    http.Response response = await http.post(
      Uri.parse(
        baseUrl + Endpoints.addShippingInfo,
      ),
      headers: {
        "X-auth-token": "$token",
        "accept": "application/json; charset=utf-8",
      },
      body: jsonEncode(
        shippingModel.toJson(),
      ),
    );

    final responseBody = RequestResponse.requestResponse(response);
    return responseBody;
  }
}
