import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/exceptions/app_exception.dart';
import 'package:intola/src/features/cart/domain/model/product_item_model.dart';
import 'package:intola/src/features/donation/domain/model/donation_model.dart';
import 'package:intola/src/features/donation/data/network/donation_network_helper.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';

class DonationRepository {
  DonationRepository({required this.donationNetworkHelper});
  final DonationNetworkHelper donationNetworkHelper;

  Future<List<DonationModel>> getDonations() async {
    try {
      var donations = await donationNetworkHelper.getDonations();

      return donations.map<DonationModel>(DonationModel.fromJson).toList();
    } on SocketException catch (ex) {
      throw AppException.dissabledNetworkException(ex.customMessage);
    } on FormatException catch (ex) {
      throw AppException.clientException(ex.customMessage);
    } catch (ex) {
      rethrow;
    }
  }

  Future updateDonationSpot({
    required id,
    required spotsleft,
  }) async {
    try {
      //update server code to update spotsLeft, only id should be provided by client
      await donationNetworkHelper.updateSpotsleft(
        id: id,
        spotsleft: spotsleft,
      );
    } on SocketException catch (ex) {
      throw DissabledNetworkException(ex.customMessage);
    } on FormatException catch (ex) {
      throw AppException.clientException(ex.customMessage);
    } catch (ex) {
      rethrow;
    }
  }

  Future<dynamic> donateProduct({required ProductItem productItem}) async {
    final product = productItem.productModel;
    try {
      await donationNetworkHelper.donateProduct(
        donationModel: DonationModel(
          image: product.image,
          price: productItem.productPrice.toString(),
          description: product.description,
          name: product.name,
          quantity: productItem.cartProductQuantity.toString(),
          spotsleft: productItem.cartProductQuantity.toString(),
        ),
      );
    } on SocketException catch (ex) {
      throw DissabledNetworkException(ex.customMessage);
    } on FormatException catch (ex) {
      throw AppException.clientException(ex.customMessage);
    } catch (ex) {
      rethrow;
    }
  }
}

final donationRepositoryProvider = Provider.autoDispose<DonationRepository>(
  (ref) => DonationRepository(
    donationNetworkHelper:
        DonationNetworkHelper(secureStorage: SecureStorage()),
  ),
);

final getDonationsProvider = FutureProvider.autoDispose((ref) {
  final donationRepository = ref.watch(donationRepositoryProvider);
  return donationRepository.getDonations();
});
