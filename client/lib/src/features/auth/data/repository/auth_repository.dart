import 'package:intola/src/features/auth/data/network/log_in_network_helper.dart';
import 'package:intola/src/features/auth/data/network/sign_up_network_helper.dart';

class AuthRepository {
  final LoginNetworkHelper _loginHelper = LoginNetworkHelper();
  final SignUpNetworkHelper _signUpHelper = SignUpNetworkHelper();

  Future<Map<String, dynamic>> loginUser(
      {required endpoint, required userEmail, required userPassword}) async {
    return _getRepositoryData(
      getData: () => _loginHelper.loginUser(
        endpoint: endpoint,
        email: userEmail,
        password: userPassword,
      ),
    );
  }

  Future<Map<String, dynamic>> registerUser({
    required endpoint,
    required userFullname,
    required userEmail,
    required userPassword,
  }) {
    return _getRepositoryData(
      getData: () => _signUpHelper.registerUser(
        endpoint: endpoint,
        fullname: userFullname,
        email: userEmail,
        password: userPassword,
      ),
    );
  }

  Future<T> _getRepositoryData<T>(
      {required Future<T> Function() getData}) async {
    try {
      return await getData();
    } catch (ex) {
      rethrow;
    }
  }
}
