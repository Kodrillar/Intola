import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intola/src/features/product/domain/model/product_model.dart';
import 'package:intola/src/features/purchase/domain/model/purchase_history_model.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';
import 'package:intola/src/utils/network/api.dart';

class PurchaseHistoryNetworkHelper {
  PurchaseHistoryNetworkHelper({required this.secureStorage});
  final SecureStorage secureStorage;
  Future<dynamic> fetchPurchaseHistory() async {
    final token = await secureStorage.read(key: "token");

    http.Response response = await http.get(
      Uri.parse(
        API.baseUrl + Endpoints.fetchPurchase,
      ),
      headers: {
        "X-auth-token": "$token",
      },
    );

    if (response.statusCode == 200) {
      var responseBody = response.body;
      return jsonDecode(responseBody)["purchase"];
    }
    throw response;
  }

  Future<dynamic> addPurchaseHistory({
    required List<ProductModel> products,
  }) async {
    final token = await secureStorage.read(key: "token");
    http.Response response = await http.post(
      Uri.parse(
        API.baseUrl + Endpoints.addPurchase,
      ),
      headers: {
        "accept": "applicaton/json; charset=utf-8",
        "content-type": "application/json",
        "X-auth-token": "$token",
      },
      body: jsonEncode(
        PurchaseHistoryModel.generateJsonPurchaseList(products),
      ),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }
}
