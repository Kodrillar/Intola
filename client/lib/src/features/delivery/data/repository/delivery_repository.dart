import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:intola/src/features/delivery/domain/model/delivery_model.dart';
import 'package:intola/src/features/delivery/data/network/delivery_network_helper.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';
import 'package:intola/src/utils/network/request_response.dart';

class DeliveryRepository {
  DeliveryRepository({required this.deliveryNetworkHelper});
  final DeliveryNetworkHelper deliveryNetworkHelper;

  Future<List<DeliveryModel>> fetchDeliveryData() async {
    try {
      var getDeliveryData = await deliveryNetworkHelper.getDelivery();
      return getDeliveryData
          .map<DeliveryModel>(DeliveryModel.fromJson)
          .toList();
    } on Response catch (response) {
      var responseBody = RequestResponse.requestResponse(response);
      return jsonDecode(responseBody);
    }
  }

  Future updateProductImage({required endpoint, required imagePath}) async {
    try {
      var productImage = await deliveryNetworkHelper.updateProductImage(
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
      var addDelivery = await deliveryNetworkHelper.addDelivery(
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

final deliveryRespositoryProvider = Provider.autoDispose<DeliveryRepository>(
  (ref) => DeliveryRepository(
    deliveryNetworkHelper: DeliveryNetworkHelper(
      secureStorage: SecureStorage(),
    ),
  ),
);

final deliveryDataProvider =
    FutureProvider.autoDispose<List<DeliveryModel>>((ref) {
  final deliveryRepository = ref.watch(deliveryRespositoryProvider);
  return deliveryRepository.fetchDeliveryData();
});
