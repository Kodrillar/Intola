import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:intola/src/features/profile/domain/model/profile_model.dart';
import 'package:intola/src/features/profile/data/network/profile_network_helper.dart';
import 'package:intola/src/utils/network/request_response.dart';

class ProfileRepository {
  final ProfileNetworkHelper _profileService = ProfileNetworkHelper();

  Future<ProfileModel> getUser({required endpoint}) async {
    try {
      var user = await _profileService.getUser(endpoint: endpoint);
      return ProfileModel.fromJson(user);
    } on Response catch (response) {
      var responseBody = RequestResponse.requestResponse(response);
      return jsonDecode(responseBody);
    }
  }
}
