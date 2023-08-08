// ignore_for_file: file_names

class AuthPostModel {
  String? email;
  String? password;

  AuthPostModel({this.email, this.password});

  AuthPostModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
