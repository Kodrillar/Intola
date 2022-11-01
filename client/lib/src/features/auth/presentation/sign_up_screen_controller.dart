import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/auth/data/repository/auth_repository.dart';

class SignUpScreenController extends StateNotifier<AsyncValue<void>> {
  SignUpScreenController({required this.authRepository})
      : super(const AsyncData(null));

  final AuthRepository authRepository;

  Future<bool> signUpUser({
    required String fullName,
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    final asyncValue = await AsyncValue.guard(
      () => authRepository.signUpUser(
        userFullName: fullName,
        userEmail: email,
        userPassword: password,
      ),
    );
    if (mounted) {
      state = asyncValue;
      return !state.hasError;
    }

    return false;
  }
}

final signUpScreenControllerProvider =
    StateNotifierProvider.autoDispose<SignUpScreenController, AsyncValue>(
  (ref) =>
      SignUpScreenController(authRepository: ref.watch(authRepositoryProvider)),
);

final obscureTextFieldTextProvider =
    StateProvider.autoDispose<bool>((ref) => true);
