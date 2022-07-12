import 'dart:convert';

import 'package:http/http.dart';
import 'package:intola/src/models/deliveryModel.dart';
import 'package:intola/src/services/delivery/deliveryService.dart';
import 'package:intola/src/utils/requestResponse.dart';

class DeliveryRepository {
  DeliveryService _deliveryService = DeliveryService();

  Future<List<DeliveryModel>> getDelivery({required endpoint}) async {
    try {
      var getDelivery = await _deliveryService.getDelivery(endpoint: endpoint);
      return getDelivery.map<DeliveryModel>(DeliveryModel.toJson).toList();
    } on Response catch (response) {
      var responseBody = RequestResponse.requestResponse(response);
      return jsonDecode(responseBody);
    }
  }

  Future updateProductImage({required endpoint, required imagePath}) async {
    try {
      var productImage = await _deliveryService.updateProductImage(
        endpoint: endpoint,
        imagePath: imagePath,
      );
      return productImage;
    } catch (ex) {
      throw ex;
    }
  }

  Future<dynamic> addDelivery({
    required endpoint,
    required weight,
    required price,
    required description,
    required location,
    required contact,
  }) async {
    try {
      var addDelivery = await _deliveryService.addDelivery(
        endpoint: endpoint,
        weight: weight,
        price: price,
        description: description,
        location: location,
        contact: contact,
      );
      return addDelivery;
    } on Response catch (response) {
      var responseBody = RequestResponse.requestResponse(response);
      return jsonDecode(responseBody);
    }
  }
}
