import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/exceptions/app_exceptions.dart';
import 'package:intola/src/features/auth/data/network/log_in_network_helper.dart';
import 'package:intola/src/features/auth/data/network/sign_up_network_helper.dart';
import 'package:intola/src/features/auth/domain/model/log_in_model.dart';
import 'package:intola/src/features/auth/domain/model/sign_up_model.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';

class AuthRepository {
  AuthRepository({
    required this.loginNetworkHelper,
    required this.signUpNetworkHelper,
    required this.secureStorage,
  });
  final LoginNetworkHelper loginNetworkHelper;
  final SignUpNetworkHelper signUpNetworkHelper;
  final SecureStorage secureStorage;

  Future<void> loginUser({required userEmail, required userPassword}) async {
    final Map<String, dynamic> loginData = await _getRepositoryData(
      getData: () => loginNetworkHelper.loginUser(
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
      getData: () => signUpNetworkHelper.signUpUser(
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
    } on SocketException {
      throw FetchDataException(
          'Unable to reach server, check your internet connection');
    } catch (ex) {
      rethrow;
    }
  }
}

final authRepositoryProvider = Provider.autoDispose<AuthRepository>(
  (ref) => AuthRepository(
      loginNetworkHelper: LoginNetworkHelper(),
      signUpNetworkHelper: SignUpNetworkHelper(),
      secureStorage: SecureStorage()),
);
