class NewPasswordParams {
  final int id;
  final String name;
  final String username;
  final String email;
  final String password;
  NewPasswordParams({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.password,
  });
  NewPasswordParams copyWith({
    int? id,
    String? name,
    String? username,
    String? email,
    String? password,
  }) {
    return NewPasswordParams(
        id: id ?? this.id,
        name: name ?? this.name,
        username: name ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'email': email,
      'password': password,
    };
  }
}
