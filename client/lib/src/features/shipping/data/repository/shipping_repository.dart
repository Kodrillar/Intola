import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:intola/src/features/shipping/data/network/shipping_network_helper.dart';
import 'package:intola/src/features/shipping/domain/model/shipping_model.dart';
import 'package:intola/src/utils/network/request_response.dart';

class ShippingRepository {
  ShippingRepository({required this.shippingNetworkHelper});
  final ShippingNetworkHelper shippingNetworkHelper;

  Future<dynamic> addShippingAddress(
      {endpoint,
      required email,
      required address,
      required city,
      required country,
      required phone,
      required zipcode}) async {
    try {
      var addShipping = await shippingNetworkHelper.addShippingAddress(
        shippingModel: ShippingModel(
          email: email,
          address: address,
          city: city,
          country: country,
          phone: phone,
          zipcode: zipcode,
        ),
      );
      return addShipping;
    } on Response catch (response) {
      var responsebody = RequestResponse.requestResponse(response);
      return jsonEncode(responsebody);
    }
  }
}

final shippingRepositoryProvider = Provider.autoDispose<ShippingRepository>(
  (ref) => ShippingRepository(shippingNetworkHelper: ShippingNetworkHelper()),
);

final addShippingAddressProvider =
    FutureProvider.autoDispose.family<void, Map>((ref, shippingRepoData) {
  final shippingRepository = ref.watch(shippingRepositoryProvider);
  return shippingRepository.addShippingAddress(
    email: shippingRepoData['email'],
    address: shippingRepoData['address'],
    city: shippingRepoData['city'],
    country: shippingRepoData['country'],
    phone: shippingRepoData['phone'],
    zipcode: shippingRepoData['zipcode'],
  );
});
