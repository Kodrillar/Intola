import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:intola/src/exceptions/app_exceptions.dart';
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
    } on SocketException {
      throw DissabledNetworkException();
    } on Response catch (response) {
      var responseBody = RequestResponse.requestResponse(response);
      return jsonDecode(responseBody);
    }
  }

  void _updateProductImage(imagePath) async {
    try {
      await deliveryNetworkHelper.updateProductImage(imagePath: imagePath);
    } on SocketException {
      throw DissabledNetworkException();
    } catch (ex) {
      rethrow;
    }
  }

  Future<dynamic> addDelivery({
    required String weight,
    required String price,
    required String description,
    required String location,
    required String contact,
    required String? imagePath,
  }) async {
    try {
      await deliveryNetworkHelper.addDelivery(
        weight: weight,
        price: price,
        description: description,
        location: location,
        contact: contact,
      );
      if (imagePath != null) {
        _updateProductImage(imagePath);
      }
    } on SocketException {
      throw DissabledNetworkException();
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
