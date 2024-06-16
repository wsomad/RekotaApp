import 'package:task_management_app/interfaces/base_model.dart';

class UserModel implements BaseModel {
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

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullname': fullname,
      'email': email,
      'password': password,
      'role': role,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> fromMap) {
    return UserModel(
      uid: fromMap['uid'],
      fullname: fromMap['fullname'],
      email: fromMap['email'],
      password: fromMap['password'],
      role: fromMap['role'],
    );
  }
  
  @override
  Map<String, dynamic> toMapBaseModel() {
    return toMap();
  }
  
  @override
  String? id;
}