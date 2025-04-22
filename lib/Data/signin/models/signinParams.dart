class SigninParams {
  String username;
  String password;

  SigninParams({required this.username, required this.password});

  SigninParams copyWith({
    String? username,
    String? password,
  }) {
    return SigninParams(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }
}
