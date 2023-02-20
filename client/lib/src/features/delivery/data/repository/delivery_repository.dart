import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/exceptions/app_exception.dart';
import 'package:intola/src/features/delivery/domain/model/delivery_model.dart';
import 'package:intola/src/features/delivery/data/network/delivery_network_helper.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';

class DeliveryRepository {
  DeliveryRepository({required this.deliveryNetworkHelper});
  final DeliveryNetworkHelper deliveryNetworkHelper;

  Future<List<DeliveryModel>> fetchDeliveryData() async {
    try {
      var getDeliveryData = await deliveryNetworkHelper.getDelivery();
      return getDeliveryData
          .map<DeliveryModel>(DeliveryModel.fromJson)
          .toList();
    } on SocketException catch (ex) {
      throw AppException.dissabledNetworkException(ex.customMessage);
    } on FormatException catch (ex) {
      throw AppException.clientException(ex.customMessage);
    } catch (ex) {
      rethrow;
    }
  }

  void _updateProductImage(imagePath) async {
    try {
      await deliveryNetworkHelper.updateProductImage(imagePath: imagePath);
    } on SocketException catch (ex) {
      throw AppException.dissabledNetworkException(ex.customMessage);
    } on FormatException catch (ex) {
      throw AppException.clientException(ex.customMessage);
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
    } on SocketException catch (ex) {
      throw AppException.dissabledNetworkException(ex.message);
    } on FormatException catch (ex) {
      throw AppException.clientException(ex.customMessage);
    } catch (ex) {
      rethrow;
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
