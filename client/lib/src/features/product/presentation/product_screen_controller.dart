import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductScreenController extends StateNotifier<int> {
  ProductScreenController() : super(10);

  void incrementCartProductQuantity() {
    state++;
  }

  void decreaseCartProductQuantity() {
    if (state > 1) {
      state--;
    }
  }
}

final productScreenControllerProvider =
    StateNotifierProvider.autoDispose<ProductScreenController, int>(
        (ref) => ProductScreenController());
