import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intola/src/features/donation/domain/model/donation_model.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';

class DonationNetworkHelper {
  // final baseUrl = "http://localhost:3000/api";
  DonationNetworkHelper({required this.secureStorage});
  final baseUrl = API.baseUrl;
  final SecureStorage secureStorage;
  Future<List<dynamic>> getDonations() async {
    final token = await secureStorage.read(key: "token");

    final http.Response response = await http.get(
      Uri.parse(
        baseUrl + Endpoints.fetchDonations,
      ),
      headers: {"X-auth-token": "$token"},
    );

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      return responseBody;
    }

    throw response;
  }

  Future donateProduct(
      {required endpoint,
      required email,
      required image,
      required price,
      required description,
      required name,
      required quantity,
      required spotsleft}) async {
    final token = await secureStorage.read(key: "token");

    DonationModel _donationModel = DonationModel(
      email: email,
      image: image,
      price: price,
      description: description,
      name: name,
      quantity: quantity,
      spotsleft: spotsleft,
    );

    final http.Response response = await http.post(
        Uri.parse(
          baseUrl + endpoint,
        ),
        headers: {
          "X-auth-token": "$token",
          "accept": "applicaton/json; charset=utf-8",
          "content-type": "application/json"
        },
        body: jsonEncode(
          _donationModel.toJson(),
        ));

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);

      return responseBody;
    }
    throw response;
  }

  Future updateSpotsleft(
      {required endpoint,
      required id,
      required email,
      required spotsleft}) async {
    final token = await secureStorage.read(key: "token");

    http.Response response = await http.put(
      Uri.parse(baseUrl + endpoint),
      headers: {
        "X-auth-token": "$token",
        "accept": "applicaton/json; charset=utf-8",
        "content-type": "application/json"
      },
      body: jsonEncode(
        {
          "email": email,
          "id": id,
          "spotsleft": spotsleft,
        },
      ),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw response;
  }
}
