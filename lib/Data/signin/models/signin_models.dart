class SigninModels {
  bool? success;
  String? message;
  User? user;
  String? token;
  String? tokenType;

  SigninModels(
      {this.success, this.message, this.user, this.token, this.tokenType});

  SigninModels.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    data['token_type'] = this.tokenType;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? username;
  int? role;

  User({this.id, this.name, this.username, this.role});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['role'] = this.role;
    return data;
  }
}
