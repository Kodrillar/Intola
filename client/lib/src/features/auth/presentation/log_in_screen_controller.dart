import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/auth/data/repository/auth_repository.dart';

class LoginScreenController extends StateNotifier<AsyncValue<void>> {
  LoginScreenController({required this.authRepository})
      : super(const AsyncData(null));

  final AuthRepository authRepository;

  Future<bool> logInUser(
      {required String email, required String password}) async {
    state = const AsyncLoading();
    final asyncValue = await AsyncValue.guard<void>(() =>
        authRepository.loginUser(userEmail: email, userPassword: password));
    if (mounted) {
      state = asyncValue;
      return !state.hasError;
    }

    return false;
  }
}

final logInScreenControllerProvider =
    StateNotifierProvider.autoDispose<LoginScreenController, AsyncValue>(
        (ref) => LoginScreenController(
            authRepository: ref.watch(authRepositoryProvider)));
