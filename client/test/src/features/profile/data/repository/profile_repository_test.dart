import 'package:flutter_test/flutter_test.dart';
import 'package:intola/src/features/profile/domain/model/profile_model.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Profile Repository', () {
    test('fetchUser() returns ProfileModel', () async {
      final profileRepository = MockProfileRepository();

      when(profileRepository.fetchUser)
          .thenAnswer((_) => Future<ProfileModel>.value(kProfileDataReplica));

      final profileData = await profileRepository.fetchUser();

      verify(profileRepository.fetchUser).called(1);
      expect(profileData, kProfileDataReplica);
    });

    test('signOutUser() deletes userToken', () async {
      final profileRepository = MockProfileRepository();

      when(profileRepository.signOutUser)
          .thenAnswer((_) => Future<void>.value());

      await profileRepository.signOutUser();

      verify(profileRepository.signOutUser).called(1);
    });
  });
}
