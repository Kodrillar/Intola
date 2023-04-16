import 'dart:async';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/exceptions/app_exception.dart';
import 'package:intola/src/features/profile/domain/model/profile_model.dart';
import 'package:intola/src/features/profile/data/network/profile_network_helper.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';

class ProfileRepository {
  ProfileRepository(
      {required this.profileNetworkHelper, required this.secureStorage});
  final ProfileNetworkHelper profileNetworkHelper;
  final SecureStorage secureStorage;

  Future<ProfileModel> fetchUser() async {
    try {
      var user = await profileNetworkHelper.fetchUserData();
      return ProfileModel.fromJson(user);
    } on SocketException catch (ex) {
      throw DissabledNetworkException(ex.customMessage);
    } on FormatException catch (ex) {
      throw AppException.clientException(ex.customMessage);
    } catch (ex) {
      rethrow;
    }
  }

  Future<void> deleteUserAccount() async {
    try {
      await Future.wait([
        profileNetworkHelper.deleteUserAccount(),
        secureStorage.delete(key: 'cart'),
        secureStorage.delete(key: 'token'),
        secureStorage.delete(key: 'userName')
      ]);
    } on SocketException catch (ex) {
      throw DissabledNetworkException(ex.customMessage);
    } on FormatException catch (ex) {
      throw AppException.clientException(ex.customMessage);
    } catch (ex) {
      rethrow;
    }
  }

  Future<void> signOutUser() async {
    await Future.wait([
      secureStorage.delete(key: 'cart'),
      secureStorage.delete(key: 'token'),
      secureStorage.delete(key: 'userName')
    ]);
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
