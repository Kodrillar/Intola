import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/auth/data/repository/auth_repository.dart';

class AuthController extends StateNotifier<AsyncValue<void>> {
  AuthController({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AsyncData(null));

  final AuthRepository _authRepository;

  Future<bool> signUpUser({
    required String fullName,
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    final asyncValue = await AsyncValue.guard(
      () => _authRepository.signUpUser(
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

  Future<bool> logInUser(
      {required String email, required String password}) async {
    state = const AsyncLoading();
    final asyncValue = await AsyncValue.guard<void>(() =>
        _authRepository.logInUser(userEmail: email, userPassword: password));
    if (mounted) {
      state = asyncValue;
      return !state.hasError;
    }

    return false;
  }
}

final authControllerProvider =
    StateNotifierProvider.autoDispose<AuthController, AsyncValue>(
  (ref) => AuthController(authRepository: ref.watch(authRepositoryProvider)),
);

final obscureTextFieldTextProvider =
    StateProvider.autoDispose<bool>((ref) => true);
