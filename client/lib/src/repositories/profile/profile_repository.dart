import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:intola/src/models/profile_Model.dart';
import 'package:intola/src/services/profile/profileService.dart';
import 'package:intola/src/utils/requestResponse.dart';

class ProfileRepository {
  ProfileService _profileService = ProfileService();

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
