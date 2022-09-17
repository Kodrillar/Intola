@Timeout(Duration(seconds: 2))
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intola/src/features/profile/presentation/profile_screen_controller.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  group('Profile Scren Controller', () {
    test('signOut() called with success ', () async {
      final profileRepository = MockProfileRepository();
      final controller =
          ProfileScreenController(profileRepository: profileRepository);

      expect(controller.debugState, const AsyncData<void>(null));

      when(profileRepository.signOutUser)
          .thenAnswer((_) => Future<void>.value());

      expect(
          controller.stream,
          emitsInOrder([
            const AsyncLoading<void>(),
            const AsyncData<void>(null),
          ]));

      await controller.signOut();

      verify(profileRepository.signOutUser).called(1);
    });

    test('signOut() called with failure', () async {
      final profileRepository = MockProfileRepository();
      final customError = Exception('sign out failed');
      final controller =
          ProfileScreenController(profileRepository: profileRepository);

      expect(controller.debugState, const AsyncData<void>(null));

      when(profileRepository.signOutUser).thenThrow(customError);

      expect(
          controller.stream,
          emitsInOrder([
            const AsyncLoading<void>(),
            predicate<AsyncError<void>>((value) {
              expect(value.hasError, true);
              return true;
            })
          ]));

      await controller.signOut();

      verify(profileRepository.signOutUser).called(1);
    });
  });
}
