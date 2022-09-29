import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/cart/domain/model/product_item_model.dart';
import 'package:intola/src/features/product/domain/model/product_model.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';

class CartRepository {
  CartRepository({required this.secureStorage});

  SecureStorage secureStorage;

  Future<void> addToCart({
    required ProductModel product,
    required int productQuantity,
  }) async {
    final Map<String, ProductItem>? cachedCartData = await fetchCart();

    if (cachedCartData != null) {
      ProductItem? productItem = cachedCartData[product.id];

      if (productItem != null) {
        _updateCartProduct(
          cachedCartData: cachedCartData,
          productId: product.id,
          productQuantity: productQuantity,
        );
        return;
      }

      _addProductToCart(
        cachedCartData: cachedCartData,
        product: product,
        productQuantity: productQuantity,
      );
      return;
    }

    _createCartWithProduct(
      product: product,
      productQuantity: productQuantity,
    );
  }

  Future<void> _createCartWithProduct(
      {required ProductModel product, required int productQuantity}) async {
    final shoppingCart = <String, ProductItem>{};

    shoppingCart[product.id] = ProductItem(
      productModel: product,
      productQuantity: productQuantity,
    );

    await secureStorage.write(
      storeObject: StoreObject(
        key: 'cart',
        value: jsonEncode(shoppingCart),
      ),
    );
  }

  Future<void> _addProductToCart({
    required Map<String, ProductItem> cachedCartData,
    required ProductModel product,
    required int productQuantity,
  }) async {
    cachedCartData.addAll({
      product.id: ProductItem(
        productModel: product,
        productQuantity: productQuantity,
      )
    });

    await secureStorage.write(
      storeObject: StoreObject(key: 'cart', value: jsonEncode(cachedCartData)),
    );
  }

  Future<void> _updateCartProduct({
    required Map<String, ProductItem> cachedCartData,
    required String productId,
    required int productQuantity,
  }) async {
    ProductItem productItem = cachedCartData[productId]!;
    productItem.productQuantity += productQuantity;
    await secureStorage.write(
      storeObject: StoreObject(
        key: 'cart',
        value: jsonEncode(cachedCartData),
      ),
    );
  }

  Future<void> deleteCartItem(String productId) async {
    final Map<String, ProductItem>? cachedCartData = await fetchCart();

    if (cachedCartData == null) return;
    cachedCartData.remove(productId);

    if (cachedCartData.isEmpty) {
      await secureStorage.delete(key: 'cart');
      return;
    }

    await secureStorage.write(
      storeObject: StoreObject(
        key: 'cart',
        value: jsonEncode(cachedCartData),
      ),
    );
  }

  Future<Map<String, ProductItem>?> fetchCart() async {
    final cachedCartData = await secureStorage.read(key: 'cart');

    if (cachedCartData != null) {
      final deserializedCartData = jsonDecode(cachedCartData) as Map;
      final Map<String, ProductItem> cartData = {};

      for (var entry in deserializedCartData.entries) {
        cartData[entry.key] = ProductItem.fromJson(jsonDecode(entry.value));
      }

      return cartData;
    }

    return null;
  }

  void getTotalPrice() {}
}

final cartRepositoryProvider = Provider.autoDispose<CartRepository>(
  (ref) => CartRepository(secureStorage: SecureStorage()),
);

final fetchCartProvider =
    FutureProvider.autoDispose<Map<String, ProductItem>?>((ref) {
  final cartRepository = ref.watch(cartRepositoryProvider);
  return cartRepository.fetchCart();
});
