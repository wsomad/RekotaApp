import 'package:task_management_app/models/user_model.dart';
import 'package:task_management_app/services/local_database_service.dart';

class UserController {
  final LocalDatabaseService _databaseService = LocalDatabaseService();

  Future<void> addUser(UserModel userModel) async {
    try {
      await _databaseService.insert('users', userModel.toMap());
    } catch (e) {
      print('Error in add user: $e');
    }
  }

  Future<UserModel?> getUser(String uid) async {
    try {
      final List<Map<String, dynamic>> map = await _databaseService.queryAll('users');
      if (map.isNotEmpty) {
        return UserModel.fromMap(map.firstWhere((element) => element['uid'] == uid));
      }
      else {
        return null;
      }
    } catch (e) {
      print('Error in get user: $e');
      return null;
    }
  }

  Future<void> updateUser(UserModel userModel) async {
    try {
      await _databaseService.update('users', userModel.uid!, userModel.toMap());
    } catch (e) {
      print('Error in update user: $e');
    }
  }

  Future<void> deleteUser(String uid) async {
    try {
      await _databaseService.delete('users', uid);
    } catch (e) {
      print('Error in delete user: $e');
    }
  }
}