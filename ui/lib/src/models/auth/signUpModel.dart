class SignUpModel {
  SignUpModel({
    required this.fullname,
    required this.email,
    required this.password,
  });

  final String fullname;
  final String email;
  final String password;

  Map<String, String> toJson() => {
        "email": email,
        "fullname": fullname,
        "password": password,
      };
}
