import 'dart:convert';

import 'package:http/http.dart';
import 'package:intola/src/models/donationModel.dart';
import 'package:intola/src/services/donation/donationService.dart';
import 'package:intola/src/utils/requestResponse.dart';

class DonationRepository {
  DonationService _donationService = DonationService();

  Future<List<DonationModel>> getDonations({required endpoint}) async {
    try {
      var donations = await _donationService.getDonations(endpoint: endpoint);

      return donations.map<DonationModel>(DonationModel.fromJson).toList();
    } on Response catch (response) {
      var responseBody = RequestResponse.requestResponse(response);
      return jsonDecode(responseBody);
    }
  }

  Future updateDonationSpot(
      {required endpoint,
      required id,
      required spotsleft,
      required email}) async {
    try {
      await _donationService.updateSpotsleft(
          endpoint: endpoint, id: id, spotsleft: spotsleft, email: email);
    } on Response catch (response) {
      var responseBody = RequestResponse.requestResponse(response);
      return responseBody;
    }
  }

  Future<dynamic> donate({
    required endpoint,
    required email,
    required image,
    required price,
    required description,
    required name,
    required quantity,
    required spotsleft,
  }) async {
    try {
      var donate = await _donationService.donate(
        endpoint: endpoint,
        email: email,
        image: image,
        price: price,
        description: description,
        name: name,
        quantity: quantity,
        spotsleft: spotsleft,
      );
      return donate;
    } on Response catch (response) {
      var responseBody = RequestResponse.requestResponse(response);
      return jsonDecode(responseBody);
    }
  }
}
