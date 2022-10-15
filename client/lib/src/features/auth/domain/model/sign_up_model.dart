class SignUpModel {
  SignUpModel({
    required this.fullName,
    required this.email,
    required this.password,
  });

  final String fullName;
  final String email;
  final String password;

  Map<String, String> toJson() => {
        "email": email,
        "fullname": fullName,
        "password": password,
      };

  @override
  String toString() =>
      'SignUpModel(fullname: $fullName, email: $email, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SignUpModel &&
        other.fullName == fullName &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode => fullName.hashCode ^ email.hashCode ^ password.hashCode;
}
