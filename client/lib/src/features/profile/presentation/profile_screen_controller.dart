import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/profile/data/repository/profile_repository.dart';

class ProfileScreenController extends StateNotifier<AsyncValue> {
  ProfileScreenController({required this.profileRepository})
      : super(const AsyncData<void>(null));
  ProfileRepository profileRepository;

  Future<bool> signOut() async {
    state = const AsyncLoading<void>();
    state = await AsyncValue.guard<void>(() => profileRepository.signOutUser());

    return state.hasError == false;
  }
}

final profileScreenControllerProvider =
    StateNotifierProvider.autoDispose<ProfileScreenController, AsyncValue>(
        (ref) {
  final profileRepository = ref.watch(profileRepositoryProvider);
  return ProfileScreenController(profileRepository: profileRepository);
});
