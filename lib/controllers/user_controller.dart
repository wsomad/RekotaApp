import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:task_management_app/interfaces/base_controller.dart';
import 'package:task_management_app/models/user_model.dart';
import 'package:task_management_app/services/local_database_service.dart';
import 'package:task_management_app/services/realtime_database_service.dart';

class UserController implements BaseController<UserModel> {
  final LocalDatabaseService _localDatabaseService = LocalDatabaseService();
  final RealtimeDatabaseService<UserModel> _onlineDatabaseService = RealtimeDatabaseService();

  Future<bool> _isOnline() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<void> _syncWithOnlineDatabase() async {
    final List<Map<String, dynamic>> localData = await _localDatabaseService.queryAll('users');
    for (var data in localData) {
      UserModel userModel = UserModel.fromMap(data);
      await _onlineDatabaseService.insert('users/${userModel.uid}', userModel);
    } 
  }

  @override
  Future<void> create(UserModel userModel, String uid) async {
    try {
      await _localDatabaseService.insert('users', userModel.toMap());
      if (await _isOnline()) {
        await _onlineDatabaseService.insert('users/$uid', userModel);
      }
    } catch (e) {
      print('Error in add user: $e');
    }
  }

  @override
  Future<UserModel?> read(String id, String uid) async {
    try {
      if (await _isOnline()) {
        UserModel? onlineUser = await _onlineDatabaseService.read('users', uid, (map) => UserModel.fromMap(map));
        if (onlineUser != null) {
          await _localDatabaseService.insert('users', onlineUser.toMap());
          return onlineUser;
        }
      }
      final List<Map<String, dynamic>> map = await _localDatabaseService.queryAll('users');
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

  @override
  Future<void> update(UserModel userModel, String uid) async {
    try {
      await _localDatabaseService.update('users', uid, userModel.toMap());
      if (await _isOnline()) {
        await _onlineDatabaseService.update('users/$uid', userModel);
      }
    } catch (e) {
      print('Error in update user: $e');
    }
  }

  @override
  Future<void> delete(String id, String uid) async {
    try {
      await _localDatabaseService.delete('users', uid);
      if (await _isOnline()) {
        await _onlineDatabaseService.delete('users/$uid', uid);
      }
    } catch (e) {
      print('Error in delete user: $e');
    }
  }

  Future<void> synchronize() async {
    if (await _isOnline()) {
      await _syncWithOnlineDatabase();
    }
  }
}