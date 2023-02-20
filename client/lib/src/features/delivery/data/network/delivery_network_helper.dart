import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intola/src/features/delivery/domain/model/delivery_model.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/utils/network/request_response.dart';

class DeliveryNetworkHelper {
  DeliveryNetworkHelper({required this.secureStorage});
  final SecureStorage secureStorage;

  Future<List<dynamic>> getDelivery() async {
    final token = await secureStorage.read(key: "token");

    http.Response response = await http.get(
      Uri.parse(
        API.baseUrl + Endpoints.fetchDelivery,
      ),
      headers: {"X-auth-token": "$token"},
    );

    final responseBody = RequestResponse.requestResponse(response);
    return responseBody;
  }

  Future<dynamic> addDelivery({
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
        API.baseUrl + Endpoints.addDelivery,
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
    final responseBody = RequestResponse.requestResponse(response);
    return responseBody;
  }

  Future updateProductImage({required imagePath}) async {
    final token = await secureStorage.read(key: "token");

    http.MultipartRequest request = http.MultipartRequest(
      "PATCH",
      Uri.parse(API.baseUrl + Endpoints.updateDeliveryImage),
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
