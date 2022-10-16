import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';

enum InitializationStatus { onboarding, authentication, homeScreen }

class UserOnboardingRepository {
  UserOnboardingRepository({required this.secureStorage});
  final SecureStorage secureStorage;

  Future<InitializationStatus> fetchInitialScreen() async {
    final userIsOnboarded = await secureStorage.read(key: 'userOnboarded');
    final userLoggedIn = await secureStorage.read(key: 'token');

    if (userIsOnboarded == null) {
      return InitializationStatus.onboarding;
    } else if (userLoggedIn == null) {
      return InitializationStatus.authentication;
    } else {
      return InitializationStatus.homeScreen;
    }
  }

  Future<void> persistOnboardingStatus() async {
    await secureStorage.write(
      storeObject: StoreObject(key: 'userOnboarded', value: 'success'),
    );
  }
}

final userOnboardingRepositoryProvider =
    Provider.autoDispose<UserOnboardingRepository>(
  (ref) => UserOnboardingRepository(secureStorage: SecureStorage()),
);

final getInitialScreenProvider =
    FutureProvider.autoDispose<InitializationStatus>((ref) {
  final userOnboardingRepository = ref.watch(userOnboardingRepositoryProvider);
  return userOnboardingRepository.fetchInitialScreen();
});

final persistOnboardingStatusProvider = FutureProvider.autoDispose<void>((ref) {
  final userOnboardingRepository = ref.watch(userOnboardingRepositoryProvider);
  return userOnboardingRepository.persistOnboardingStatus();
});
