import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/exceptions/app_exception.dart';
import 'package:intola/src/features/auth/domain/model/log_in_model.dart';
import 'package:intola/src/features/auth/domain/model/sign_up_model.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';

import '../network/auth_network_helper.dart';

class AuthRepository {
  AuthRepository(
      {required this.secureStorage,
      required AuthNetworkHelper authNetworkHelper})
      : _authNetworkHelper = authNetworkHelper;

  final AuthNetworkHelper _authNetworkHelper;
  final SecureStorage secureStorage;

  Future<void> logInUser({required userEmail, required userPassword}) async {
    final Map<String, dynamic> loginData = await _getRepositoryData(
      getData: () => _authNetworkHelper.loginUser(
        logInModel: LogInModel(email: userEmail, password: userPassword),
      ),
    );

    final userToken = loginData["token"];
    //cache userToken
    await secureStorage.write(
        storeObject: StoreObject(key: "token", value: userToken));
    //cache userEmail
    await secureStorage.write(
        storeObject: StoreObject(key: "userName", value: userEmail));
  }

  Future<void> signUpUser({
    required userFullName,
    required userEmail,
    required userPassword,
  }) async {
    final Map<String, dynamic> signUpData = await _getRepositoryData(
      getData: () => _authNetworkHelper.signUpUser(
          signUpModel: SignUpModel(
        fullName: userFullName,
        email: userEmail,
        password: userPassword,
      )),
    );

    final userToken = signUpData['token'];

    //cache userToken
    await SecureStorage().write(
      storeObject: StoreObject(key: "token", value: userToken),
    );

    //cache userEmail
    await SecureStorage().write(
      storeObject: StoreObject(key: "userName", value: userEmail),
    );
  }

  Future<T> _getRepositoryData<T>(
      {required Future<T> Function() getData}) async {
    try {
      return await getData();
    } on SocketException catch (ex) {
      throw AppException.dissabledNetworkException(ex.customMessage);
    } on FormatException catch (ex) {
      throw AppException.clientException(ex.customMessage);
    } catch (ex) {
      rethrow;
    }
  }
}

final authRepositoryProvider = Provider.autoDispose<AuthRepository>(
  (ref) => AuthRepository(
      authNetworkHelper: AuthNetworkHelper(), secureStorage: SecureStorage()),
);
