import 'dart:convert';
import 'package:http/http.dart';
import 'package:intola/src/features/delivery/domain/model/delivery_model.dart';
import 'package:intola/src/features/delivery/data/network/delivery_network_helper.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';
import 'package:intola/src/utils/network/request_response.dart';

class DeliveryRepository {
  //change this
  final DeliveryNetworkHelper _deliveryNetworkHelper =
      DeliveryNetworkHelper(secureStorage: SecureStorage());

  Future<List<DeliveryModel>> getDelivery({required endpoint}) async {
    try {
      var getDelivery =
          await _deliveryNetworkHelper.getDelivery(endpoint: endpoint);
      return getDelivery.map<DeliveryModel>(DeliveryModel.toJson).toList();
    } on Response catch (response) {
      var responseBody = RequestResponse.requestResponse(response);
      return jsonDecode(responseBody);
    }
  }

  Future updateProductImage({required endpoint, required imagePath}) async {
    try {
      var productImage = await _deliveryNetworkHelper.updateProductImage(
        endpoint: endpoint,
        imagePath: imagePath,
      );
      return productImage;
    } catch (ex) {
      rethrow;
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
      var addDelivery = await _deliveryNetworkHelper.addDelivery(
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
