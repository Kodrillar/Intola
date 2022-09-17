class ProfileModel {
  const ProfileModel({
    required this.email,
    required this.fullname,
  });
  final String email;
  final String fullname;

  ProfileModel.fromJson(json)
      : email = json["email"],
        fullname = json["fullname"];
}
