import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/auth/presentation/screen/log_in/log_in_screen.dart';
import 'package:intola/src/features/home/presentation/screen/home_screen.dart';
import 'package:intola/src/features/user_onboarding/presentation/screen/onboarding_screen.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';

class CacheRepository {
  Future<Widget> fetchInitialScreen() async {
    await Future.delayed(const Duration(seconds: 1));
    final userIsOnboarded =
        await SecureStorage.storage.read(key: 'userOnboarded');
    final userLoggedIn = await SecureStorage.storage.read(key: 'token');

    if (userIsOnboarded == null) {
      return OnboardingScreen();
    } else if (userLoggedIn == null) {
      return const LoginScreen();
    } else {
      return const HomeScreen();
    }
  }
}

final cacheRepositoryProvider = Provider<CacheRepository>(
  (ref) => CacheRepository(),
);

final getInitialScreenProvider = FutureProvider<Widget>((ref) {
  final cacheRepsitory = ref.watch(cacheRepositoryProvider);
  return cacheRepsitory.fetchInitialScreen();
});
