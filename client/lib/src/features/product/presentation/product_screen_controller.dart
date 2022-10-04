import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/cart/data/repository/cart_repository.dart';
import 'package:intola/src/features/product/domain/model/product_model.dart';

class ProductScreenController extends StateNotifier<AsyncValue> {
  ProductScreenController({required this.cartRepository})
      : super(const AsyncData(null));

  final CartRepository cartRepository;

  Future<void> addProductToCart(
      {required ProductModel product, required cartProductQuantity}) async {
    state = const AsyncLoading();
    final asyncValue = await AsyncValue.guard(() => cartRepository.addToCart(
          product: product,
          cartProductQuantity: cartProductQuantity,
        ));
    if (mounted) {
      state = asyncValue;
    }
  }
}

final productScreenControllerProvider =
    StateNotifierProvider.autoDispose<ProductScreenController, AsyncValue>(
  (ref) => ProductScreenController(
      cartRepository: ref.watch(cartRepositoryProvider)),
);
