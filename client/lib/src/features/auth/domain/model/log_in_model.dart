class LogInModel {
  LogInModel({required this.email, required this.password});

  final String email;
  final String password;

  Map<String, String> toJson() => {
        "email": email,
        "password": password,
      };

  @override
  String toString() => 'LogInModel(email: $email, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LogInModel &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
