class CreateAccountParams {
  final String name;
  final String username;
  final String password;
  final String email;
  final String role;

  CreateAccountParams({
    required this.name,
    required this.username,
    required this.password,
    required this.email,
    required this.role,
  });
  CreateAccountParams copyWith({
    String? name,
    String? username,
    String? password,
    String? email,
    String? role,
  }) {
    return CreateAccountParams(
      name: name ?? this.name,
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      role: email ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': username,
      'username': username,
      'password': password,
      'email': email,
    };
  }
}
