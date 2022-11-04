import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:intola/src/exceptions/app_exceptions.dart';
import 'package:intola/src/features/cart/data/repository/cart_repository.dart';
import 'package:intola/src/features/cart/domain/model/product_item_model.dart';
import 'package:intola/src/features/donation/domain/model/donation_model.dart';
import 'package:intola/src/features/product/domain/model/product_model.dart';
import 'package:intola/src/features/purchase/domain/model/purchase_history_model.dart';
import 'package:intola/src/features/purchase/data/network/purchase_network_helper.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';
import 'package:intola/src/utils/network/request_response.dart';

class PurchaseHistoryRepository {
  PurchaseHistoryRepository(
      {required this.purchaseHistoryNetworkHelper,
      required this.cartRepository,
      required this.secureStorage});

  final PurchaseHistoryNetworkHelper purchaseHistoryNetworkHelper;

  final SecureStorage secureStorage;
  final CartRepository cartRepository;
  final List<ProductModel> _products = [];

  Future<List<PurchaseHistoryModel>> fetchPurchaseHistory() async {
    try {
      final purchaseHistoryData =
          await purchaseHistoryNetworkHelper.fetchPurchaseHistory();

      final List<Map> purchasedProductList = [];

      //TODO: improve time complexity
      for (var purchase in purchaseHistoryData) {
        for (var product in purchase['products']) {
          purchasedProductList.add({
            'id': purchase['id'],
            'name': product['name'],
            'image': product['image'],
            'status': product['status'],
            'date': purchase['created_at']
          });
        }
      }

      return purchasedProductList
          .map<PurchaseHistoryModel>(PurchaseHistoryModel.fromJson)
          .toList();
    } on SocketException {
      throw DissabledNetworkException();
    } on Response catch (response) {
      final responseBody = RequestResponse.requestResponse(response);
      return jsonDecode(responseBody);
    }
  }

  Future<void> addPurchaseHistory({DonationModel? donationProduct}) async {
    try {
      if (donationProduct == null) {
        Map<String, ProductItem>? shoppingCart =
            await cartRepository.fetchCart();

        if (shoppingCart == null) return;

        for (var entry in shoppingCart.entries) {
          _products.add(entry.value.productModel);
        }
        //add purchases to db
        await purchaseHistoryNetworkHelper.addPurchaseHistory(
          products: _products,
        );

        //clear cart after purchases
        await secureStorage.delete(key: 'cart');
      } else {
        _addDonationProductToPurchaseHistory(donationProduct);
      }
    } on SocketException {
      throw DissabledNetworkException();
    } on Response catch (response) {
      final responseBody = RequestResponse.requestResponse(response);
      return jsonDecode(responseBody);
    }
  }

  Future<void> _addDonationProductToPurchaseHistory(
      DonationModel donation) async {
    _products.add(
      ProductModel(
        id: donation.id!,
        name: donation.name,
        image: donation.image,
        price: donation.price,
        slashprice: donation.price,
        description: donation.description,
        quantity: donation.quantity,
      ),
    );
    try {
      await purchaseHistoryNetworkHelper.addPurchaseHistory(
        products: _products,
      );
    } on SocketException {
      throw DissabledNetworkException();
    } on Response catch (response) {
      final responseBody = RequestResponse.requestResponse(response);
      return jsonDecode(responseBody);
    }
  }
}

final purchaseHistoryRepositoryProvider =
    Provider.autoDispose<PurchaseHistoryRepository>((ref) {
  final SecureStorage secureStorage = SecureStorage();

  return PurchaseHistoryRepository(
    secureStorage: secureStorage,
    cartRepository: CartRepository(secureStorage: secureStorage),
    purchaseHistoryNetworkHelper: PurchaseHistoryNetworkHelper(
      secureStorage: secureStorage,
    ),
  );
});

final fetchPurchaseHistoryProvider =
    FutureProvider.autoDispose<List<PurchaseHistoryModel>>((ref) {
  final purchaseHistoryRepository =
      ref.watch(purchaseHistoryRepositoryProvider);

  return purchaseHistoryRepository.fetchPurchaseHistory();
});
