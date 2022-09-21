import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:intola/src/features/donation/domain/model/donation_model.dart';
import 'package:intola/src/features/donation/data/network/donation_network_helper.dart';
import 'package:intola/src/utils/network/request_response.dart';

class DonationRepository {
  DonationRepository({required this.donationNetworkHelper});
  final DonationNetworkHelper donationNetworkHelper;

  Future<List<DonationModel>> getDonations() async {
    try {
      var donations = await donationNetworkHelper.getDonations();

      return donations.map<DonationModel>(DonationModel.fromJson).toList();
    } on Response catch (response) {
      var responseBody = RequestResponse.requestResponse(response);
      return jsonDecode(responseBody);
    }
  }

  Future updateDonationSpot({
    required endpoint,
    required id,
    required spotsleft,
    required email,
  }) async {
    try {
      await donationNetworkHelper.updateSpotsleft(
          endpoint: endpoint, id: id, spotsleft: spotsleft, email: email);
    } on Response catch (response) {
      var responseBody = RequestResponse.requestResponse(response);
      return responseBody;
    }
  }

  Future<dynamic> donateProduct({
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
      var donate = await donationNetworkHelper.donateProduct(
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

final donationRepositoryProvider = Provider.autoDispose<DonationRepository>(
  (ref) => DonationRepository(donationNetworkHelper: DonationNetworkHelper()),
);

final getDonationsProvider = FutureProvider.autoDispose((ref) {
  final donationRepository = ref.watch(donationRepositoryProvider);
  return donationRepository.getDonations();
});
