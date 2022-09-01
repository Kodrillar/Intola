import 'dart:convert';

import 'package:http/http.dart';
import 'package:intola/src/features/shipping/data/network/shipping_network_helper.dart';
import 'package:intola/src/utils/network/request_response.dart';

class ShippingRepository {
  final ShippingNetworkHelper _shippingService = ShippingNetworkHelper();

  Future<dynamic> addShippingAddress(
      {required endpoint,
      required email,
      required address,
      required city,
      required country,
      required phone,
      required zipcode}) async {
    try {
      var addShipping = await _shippingService.addShippingAddress(
        endpoint: endpoint,
        email: email,
        address: address,
        city: city,
        country: country,
        phone: phone,
        zipcode: zipcode,
      );
      return addShipping;
    } on Response catch (response) {
      var responsebody = RequestResponse.requestResponse(response);
      return jsonEncode(responsebody);
    }
  }
}