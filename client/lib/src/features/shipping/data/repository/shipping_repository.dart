import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/exceptions/app_exception.dart';
import 'package:intola/src/features/shipping/data/network/shipping_network_helper.dart';
import 'package:intola/src/features/shipping/domain/model/shipping_model.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';

class ShippingInfoRepository {
  ShippingInfoRepository({required this.shippingNetworkHelper});
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
    } on SocketException catch (ex) {
      throw AppException.dissabledNetworkException(ex.customMessage);
    } on FormatException catch (ex) {
      throw AppException.clientException(ex.customMessage);
    } catch (ex) {
      rethrow;
    }
  }
}

final shippingRepositoryProvider = Provider.autoDispose<ShippingInfoRepository>(
  (ref) => ShippingInfoRepository(
    shippingNetworkHelper: ShippingNetworkHelper(
      secureStorage: SecureStorage(),
    ),
  ),
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
