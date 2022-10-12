import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/auth/presentation/screen/log_in/log_in_screen.dart';
import 'package:intola/src/features/home/presentation/screen/home_screen.dart';
import 'package:intola/src/features/user_onboarding/presentation/screen/onboarding_screen.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';

class UserOnboardingRepository {
  UserOnboardingRepository({required this.secureStorage});
  final SecureStorage secureStorage;

  Future<Widget> fetchInitialScreen() async {
    const userIsOnboarded = null;
    // await secureStorage.read(key: 'userOnboarded');
    final userLoggedIn = await secureStorage.read(key: 'token');

    if (userIsOnboarded == null) {
      return OnboardingScreen();
    } else if (userLoggedIn == null) {
      return const LoginScreen();
    } else {
      return const HomeScreen();
    }
  }
}

final userOnboardingRepositoryProvider =
    Provider.autoDispose<UserOnboardingRepository>(
  (ref) => UserOnboardingRepository(secureStorage: SecureStorage()),
);

final getInitialScreenProvider = FutureProvider.autoDispose<Widget>((ref) {
  final userOnboardingRepository = ref.watch(userOnboardingRepositoryProvider);
  return userOnboardingRepository.fetchInitialScreen();
});
