class AuthRegisterModel {
  String? firstname;
  String? lastname;
  String? email;
  String? phone;
  String? password;
  String? role;

  AuthRegisterModel(
      {this.firstname,
      this.lastname,
      this.email,
      this.phone,
      this.password,
      this.role});

  AuthRegisterModel.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    data['role'] = role;
    return data;
  }
}
