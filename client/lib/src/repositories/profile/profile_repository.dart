import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:intola/src/models/profile_model.dart';
import 'package:intola/src/services/profile/profile_service.dart';
import 'package:intola/src/utils/network/request_response.dart';

class ProfileRepository {
  final ProfileService _profileService = ProfileService();

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
