import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intola/src/models/purchase_history_model.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';

class PurchaseHistoryService {
  // final baseUrl = "http://localhost:3000/api";
  final baseUrl = "https://intola.herokuapp.com/api";
  Future<dynamic> getPurchaseHistory({required endpoint}) async {
    final token = await SecureStorage.storage.read(key: "token");

    http.Response response = await http.get(
      Uri.parse(
        baseUrl + endpoint,
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
    required endpoint,
    required email,
    required image,
    required name,
  }) async {
    PurchaseHistoryModel _purchaseHistoryModel = PurchaseHistoryModel(
      email: email,
      image: image,
      name: name,
    );
    final token = await SecureStorage.storage.read(key: "token");
    http.Response response = await http.post(
      Uri.parse(
        baseUrl + endpoint,
      ),
      headers: {
        "accept": "applicaton/json; charset=utf-8",
        "content-type": "application/json",
        "X-auth-token": "$token",
      },
      body: jsonEncode(
        _purchaseHistoryModel.toJson(),
      ),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }
}
