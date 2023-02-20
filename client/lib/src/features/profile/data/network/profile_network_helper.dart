import 'package:http/http.dart' as http;
import 'package:intola/src/utils/cache/secure_storage.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/utils/network/request_response.dart';

class ProfileNetworkHelper {
  ProfileNetworkHelper({required this.secureStorage});
  final baseUrl = API.baseUrl;
  final SecureStorage secureStorage;
  Future<dynamic> fetchUserData() async {
    final user = await secureStorage.read(key: 'userName');
    http.Response response = await http.get(
      Uri.parse(baseUrl + Endpoints.fetchUserDetails + '/$user'),
      headers: {
        "Content-Type": "application/json",
      },
    );
    final responseBody = RequestResponse.requestResponse(response);
    return responseBody["user"];
  }
}
