import 'package:SummitDocs/Data/signin/models/signin_models.dart';

class UserModel {
  int? id;
  String? name;
  String? username;
  String? email;
  String? emailVerifiedAt;
  int? roleId;
  String? createdAt;
  String? updatedAt;

  UserModel(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.emailVerifiedAt,
      this.roleId,
      this.createdAt,
      this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    roleId = int.tryParse(json['role_id']);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['role_id'] = this.roleId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
