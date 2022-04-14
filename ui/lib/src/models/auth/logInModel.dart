class LogInModel {
  LogInModel({required this.email, required this.password});

  final String email;
  final String password;

  Map<String, String> toJson() => {
        "email": email,
        "password": password,
      };
}
