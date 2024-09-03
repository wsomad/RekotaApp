import 'package:task_management_app/interfaces/base_model.dart';

class UserModel implements BaseModel {
  String? uid;
  String? username;
  String? email;
  String? password;
  String? role;

  UserModel({
    this.uid,
    this.username,
    this.email,
    this.password,
    this.role,
  });

  @override
  String? get id => uid;

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'password': password,
      'role': role,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> fromMap) {
    return UserModel(
      uid: fromMap['uid'],
      username: fromMap['username'],
      email: fromMap['email'],
      password: fromMap['password'],
      role: fromMap['role'],
    );
  }
  
  @override
  Map<String, dynamic> toMapBaseModel() {
    return toMap();
  }
}