class UserEntity {
  int? id;
  String? name;
  String? username;
  String? email;
  String? emailVerifiedAt;
  int? roleId;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserEntity(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.emailVerifiedAt,
      this.roleId,
      this.createdAt,
      this.updatedAt});
}
