import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/profile/data/repository/profile_repository.dart';
import 'package:intola/src/features/profile/presentation/profile_screen_state.dart';

class ProfileScreenController extends StateNotifier<ProfileScreenState> {
  ProfileScreenController(
      {required this.profileRepository, required AsyncValue profileAsyncValue})
      : super(
          ProfileScreenState(
              profileAsyncValue: profileAsyncValue,
              signOutAsyncValue: const AsyncData<void>(null)),
        );
  ProfileRepository profileRepository;

  Future<bool> signOut() async {
    state = state.copyWith(signOutAsyncValue: const AsyncLoading<void>());
    final asyncResult =
        await AsyncValue.guard(() => profileRepository.signOutUser());
    if (mounted) {
      state = state.copyWith(signOutAsyncValue: asyncResult);
    }

    return state.signOutAsyncValue.hasError == false;
  }

  Future<void> updateOnReload() async {
    state = state.copyWith(profileAsyncValue: const AsyncLoading<void>());
    final asyncResult =
        await AsyncValue.guard(() => profileRepository.fetchUser());
    if (mounted) {
      state = state.copyWith(profileAsyncValue: asyncResult);
    }
  }
}

final profileScreenControllerProvider = StateNotifierProvider.autoDispose<
    ProfileScreenController, ProfileScreenState>((ref) {
  final profileRepository = ref.watch(profileRepositoryProvider);
  final asyncValue = ref.watch(fetchUserProfileProvider);
  return ProfileScreenController(
      profileRepository: profileRepository, profileAsyncValue: asyncValue);
});
