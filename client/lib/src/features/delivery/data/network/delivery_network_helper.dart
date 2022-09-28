import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intola/src/features/delivery/domain/model/delivery_model.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';

class DeliveryNetworkHelper {
  // final baseUrl = "http://localhost:3000/api";
  DeliveryNetworkHelper({required this.secureStorage});
  final baseUrl = "https://intola.herokuapp.com/api";
  final SecureStorage secureStorage;

  Future<List<dynamic>> getDelivery({required endpoint}) async {
    final token = await secureStorage.read(key: "token");

    http.Response response = await http.get(
      Uri.parse(
        baseUrl + endpoint,
      ),
      headers: {"X-auth-token": "$token"},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  Future<dynamic> addDelivery({
    required endpoint,
    required weight,
    required price,
    required description,
    required location,
    required contact,
  }) async {
    DeliveryModel _deliveryModel = DeliveryModel(
      weight: weight,
      price: price,
      description: description,
      location: location,
      contact: contact,
    );
    final token = await secureStorage.read(key: "token");

    http.Response response = await http.post(
      Uri.parse(
        baseUrl + endpoint,
      ),
      headers: {
        "content-type": "application/json",
        "accept": "application/json; charset=utf-8",
        "X-auth-token": "$token"
      },
      body: jsonEncode(
        _deliveryModel.toJson(),
      ),
    );
    debugPrint(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  Future updateProductImage({required endpoint, required imagePath}) async {
    final token = await secureStorage.read(key: "token");

    http.MultipartRequest request = http.MultipartRequest(
      "PATCH",
      Uri.parse(baseUrl + endpoint),
    );
    request.files.add(await http.MultipartFile.fromPath("image", imagePath));
    request.headers.addAll({
      "content-type": "multipart/form-data",
      "X-auth-token": "$token",
    });

    var response = await request.send();
    return response;
  }
}
