import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/cart/data/repository/cart_repository.dart';

class CartScreenController extends StateNotifier<AsyncValue<double?>> {
  CartScreenController({required this.cartRepository})
      : super(const AsyncData<double?>(null));

  final CartRepository cartRepository;

  Future<double?> getCartTotalPrice() async {
    state = const AsyncLoading<double?>();
    final result = await AsyncValue.guard(() => cartRepository.getTotalPrice());
    if (mounted) {
      state = result;
      return state.value;
    }
    return null;
  }
}

final cartScreenControllerProvider =
    StateNotifierProvider.autoDispose<CartScreenController, AsyncValue>(
  (ref) =>
      CartScreenController(cartRepository: ref.watch(cartRepositoryProvider)),
);
