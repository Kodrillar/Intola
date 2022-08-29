import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intola/src/models/delivery_Model.dart';
import 'package:intola/src/utils/secureStorage.dart';

class DeliveryService {
  // final baseUrl = "http://localhost:3000/api";
  final baseUrl = "https://intola.herokuapp.com/api";

  Future<List<dynamic>> getDelivery({required endpoint}) async {
    final token = await SecureStorage.storage.read(key: "token");

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
    final token = await SecureStorage.storage.read(key: "token");

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
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  Future updateProductImage({required endpoint, required imagePath}) async {
    final token = await SecureStorage.storage.read(key: "token");

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
