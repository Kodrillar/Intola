import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:intola/src/exceptions/app_exceptions.dart';
import 'package:intola/src/features/profile/domain/model/profile_model.dart';
import 'package:intola/src/features/profile/data/network/profile_network_helper.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';
import 'package:intola/src/utils/network/request_response.dart';

class ProfileRepository {
  ProfileRepository(
      {required this.profileNetworkHelper, required this.secureStorage});
  final ProfileNetworkHelper profileNetworkHelper;
  final SecureStorage secureStorage;

  Future<ProfileModel> fetchUser() async {
    try {
      var user = await profileNetworkHelper.fetchUserData();
      return ProfileModel.fromJson(user);
    } on SocketException {
      throw DissabledNetworkException();
    } on Response catch (response) {
      var responseBody = RequestResponse.requestResponse(response);
      return jsonDecode(responseBody);
    }
  }

  Future<void> signOutUser() async {
    await secureStorage.delete(key: 'cart');
    await secureStorage.delete(key: 'token');
  }
}

final profileRepositoryProvider = Provider.autoDispose<ProfileRepository>(
  (ref) => ProfileRepository(
      profileNetworkHelper:
          ProfileNetworkHelper(secureStorage: SecureStorage()),
      secureStorage: SecureStorage()),
);

final fetchUserProfileProvider =
    FutureProvider.autoDispose<ProfileModel>((ref) {
  final profileRepository = ref.watch(profileRepositoryProvider);
  return profileRepository.fetchUser();
});
