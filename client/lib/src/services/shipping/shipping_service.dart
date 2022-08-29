import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intola/src/models/shipping_model.dart';
import 'package:intola/src/utils/secure_storage.dart';

class ShippingService {
  // final baseUrl = "http://localhost:3000/api";
  final baseUrl = "https://intola.herokuapp.com/api";

  Future<dynamic> addShippingAddress({
    required endpoint,
    required email,
    required address,
    required city,
    required country,
    required phone,
    required zipcode,
    String? apartmentSuite,
  }) async {
    ShippingModel _shippingModel = ShippingModel(
      email: email,
      address: address,
      city: city,
      country: country,
      phone: phone,
      zipcode: zipcode,
      apartmentSuite: apartmentSuite,
    );
    final token = SecureStorage.storage.read(key: "token");
    http.Response response = await http.post(
      Uri.parse(
        baseUrl + endpoint,
      ),
      headers: {
        "X-auth-token": "$token",
        "accept": "application/json; charset=utf-8",
      },
      body: jsonEncode(
        _shippingModel.toJson(),
      ),
    );

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      return responseBody;
    }
    throw response;
  }
}
