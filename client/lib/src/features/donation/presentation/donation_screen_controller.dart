import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/donation/data/repository/donation_repository.dart';

class DonationScreenController extends StateNotifier<AsyncValue> {
  DonationScreenController(
      {required this.donationRepository, required AsyncValue asyncValue})
      : super(asyncValue);

  DonationRepository donationRepository;

  Future<void> updateOnReload() async {
    state = const AsyncLoading();
    final asyncResult =
        await AsyncValue.guard(() => donationRepository.getDonations());
    if (mounted) {
      state = asyncResult;
    }
  }
}

final donationScreenControllerProvider =
    StateNotifierProvider.autoDispose<DonationScreenController, AsyncValue>(
        (ref) {
  final asyncValue = ref.watch(getDonationsProvider);
  final donationRepository = ref.watch(donationRepositoryProvider);
  return DonationScreenController(
      donationRepository: donationRepository, asyncValue: asyncValue);
});
