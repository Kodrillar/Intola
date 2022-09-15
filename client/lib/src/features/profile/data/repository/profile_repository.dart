import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:intola/src/features/profile/domain/model/profile_model.dart';
import 'package:intola/src/features/profile/data/network/profile_network_helper.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';
import 'package:intola/src/utils/network/request_response.dart';

class ProfileRepository {
  ProfileRepository({required this.profileNetworkHelper});
  final ProfileNetworkHelper profileNetworkHelper;

  Future<ProfileModel> getUser() async {
    try {
      var user = await profileNetworkHelper.getUser();
      return ProfileModel.fromJson(user);
    } on Response catch (response) {
      var responseBody = RequestResponse.requestResponse(response);
      return jsonDecode(responseBody);
    }
  }

  Future<void> signOutUser() async {
    throw Exception('badd');
    await SecureStorage.storage.delete(key: 'token');
  }
}

final profileRepositoryProvider = Provider.autoDispose<ProfileRepository>(
  (ref) => ProfileRepository(
    profileNetworkHelper: ProfileNetworkHelper(),
  ),
);

final fetchUserProfileProvider =
    FutureProvider.autoDispose<ProfileModel>((ref) {
  final profileRepository = ref.watch(profileRepositoryProvider);
  return profileRepository.getUser();
});
