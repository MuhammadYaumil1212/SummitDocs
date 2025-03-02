class SigninParams {
  String email;
  String password;

  SigninParams({required this.email, required this.password});

  SigninParams copyWith({
    String? email,
    String? password,
  }) {
    return SigninParams(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
}
