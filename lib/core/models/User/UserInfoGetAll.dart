class UserInfoGetAllModel {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? registeredDate;
  String? role;
  bool? enabled;
  List<Authorities>? authorities;
  String? username;
  bool? accountNonLocked;
  bool? accountNonExpired;
  bool? credentialsNonExpired;

  UserInfoGetAllModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.registeredDate,
      this.role,
      this.enabled,
      this.authorities,
      this.username,
      this.accountNonLocked,
      this.accountNonExpired,
      this.credentialsNonExpired});

  UserInfoGetAllModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    registeredDate = json['registeredDate'];
    role = json['role'];
    enabled = json['enabled'];
    if (json['authorities'] != null) {
      authorities = <Authorities>[];
      json['authorities'].forEach((v) {
        authorities!.add(Authorities.fromJson(v));
      });
    }
    username = json['username'];
    accountNonLocked = json['accountNonLocked'];
    accountNonExpired = json['accountNonExpired'];
    credentialsNonExpired = json['credentialsNonExpired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['registeredDate'] = registeredDate;
    data['role'] = role;
    data['enabled'] = enabled;
    if (authorities != null) {
      data['authorities'] = authorities!.map((v) => v.toJson()).toList();
    }
    data['username'] = username;
    data['accountNonLocked'] = accountNonLocked;
    data['accountNonExpired'] = accountNonExpired;
    data['credentialsNonExpired'] = credentialsNonExpired;
    return data;
  }
}

class Authorities {
  String? authority;

  Authorities({this.authority});

  Authorities.fromJson(Map<String, dynamic> json) {
    authority = json['authority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['authority'] = authority;
    return data;
  }
}
