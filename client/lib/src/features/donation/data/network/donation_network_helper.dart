import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intola/src/features/donation/domain/model/donation_model.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';
import 'package:intola/src/utils/network/request_response.dart';

class DonationNetworkHelper {
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

    final responseBody = RequestResponse.requestResponse(response);
    return responseBody;
  }

  Future donateProduct({required DonationModel donationModel}) async {
    final token = await secureStorage.read(key: "token");

    final http.Response response = await http.post(
        Uri.parse(
          baseUrl + Endpoints.addDonation,
        ),
        headers: {
          "X-auth-token": "$token",
          "accept": "applicaton/json; charset=utf-8",
          "content-type": "application/json"
        },
        body: jsonEncode(
          donationModel.toJson(),
        ));

    final responseBody = RequestResponse.requestResponse(response);
    return responseBody;
  }

  Future updateSpotsleft({required id, required spotsleft}) async {
    final token = await secureStorage.read(key: "token");

    http.Response response = await http.put(
      Uri.parse(baseUrl + Endpoints.updateDonation),
      headers: {
        "X-auth-token": "$token",
        "accept": "applicaton/json; charset=utf-8",
        "content-type": "application/json"
      },
      body: jsonEncode(
        {
          "id": id,
          "spotsleft": spotsleft,
        },
      ),
    );
    final responseBody = RequestResponse.requestResponse(response);
    return responseBody;
  }
}
