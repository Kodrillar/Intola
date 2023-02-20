import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/purchase/data/repository/purchase_repository.dart';

class PurchaseHistoryScreenController extends StateNotifier<AsyncValue> {
  PurchaseHistoryScreenController(
      {required this.purchaseHistoryRepository, required AsyncValue asyncValue})
      : super(asyncValue);

  PurchaseHistoryRepository purchaseHistoryRepository;

  Future<void> updateOnReload() async {
    state = const AsyncLoading();
    final asyncResult = await AsyncValue.guard(
        () => purchaseHistoryRepository.fetchPurchaseHistory());
    if (mounted) {
      state = asyncResult;
    }
  }
}

final purchaseHistoryScreenControllerProvider = StateNotifierProvider
    .autoDispose<PurchaseHistoryScreenController, AsyncValue>((ref) {
  final asyncValue = ref.watch(fetchPurchaseHistoryProvider);
  final purchaseHistoryRepository =
      ref.watch(purchaseHistoryRepositoryProvider);
  return PurchaseHistoryScreenController(
      purchaseHistoryRepository: purchaseHistoryRepository,
      asyncValue: asyncValue);
});
