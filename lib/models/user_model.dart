class UserModel {
  String? uid;
  String? fullname;
  String? email;
  String? password;
  String? role;

  UserModel({
    this.uid,
    this.fullname,
    this.email,
    this.password,
    this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'fullname': fullname,
      'email': email,
      'password': password,
      'role': role,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> fromJson) {
    return UserModel(
      uid: fromJson['uid'],
      fullname: fromJson['fullname'],
      email: fromJson['email'],
      password: fromJson['password'],
      role: fromJson['role'],
    );
  }
}