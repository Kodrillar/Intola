import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intola/src/features/shipping/domain/model/shipping_model.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';
import 'package:intola/src/utils/network/api.dart';

class ShippingNetworkHelper {
  // final baseUrl = "http://localhost:3000/api";
  final baseUrl = API.baseUrl;

  Future<void> addShippingAddress(
      {required ShippingModel shippingModel}) async {
    final token = SecureStorage.storage.read(key: "token");
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

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      return responseBody;
    }
    throw response;
  }
}
