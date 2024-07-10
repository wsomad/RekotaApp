import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:task_management_app/interfaces/base_controller.dart';
import 'package:task_management_app/models/task_model.dart';
import 'package:task_management_app/models/user_model.dart';
import 'package:task_management_app/services/local_database_service.dart';
import 'package:task_management_app/services/realtime_database_service.dart';

class TaskController implements BaseController<TaskModel>{
  final LocalDatabaseService _localDatabaseService = LocalDatabaseService();
  final RealtimeDatabaseService<TaskModel> _onlineDatabaseService = RealtimeDatabaseService();

  Future<bool> _isOnline() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<void> _syncWithOnlineDatabase(String uid) async {
    final List<Map<String, dynamic>> localData = await _localDatabaseService.queryAll('tasks');
    for (var data in localData) {
      TaskModel taskModel = TaskModel.fromMap(data);
      await _onlineDatabaseService.insert('users/$uid/tasks/${taskModel.id}', taskModel);
    } 
  }

  @override
  Future<void> create(TaskModel taskModel, String uid) async {
    try {
      await _localDatabaseService.insert('tasks', taskModel.toMap());
      if (await _isOnline()) {
        await _onlineDatabaseService.insert('users/$uid/tasks/${taskModel.id}', taskModel);
      }
    } catch (e) {
      print('Error in add task: $e');
    }
  }

  @override
  Future<TaskModel?> read(String id, String uid) async {
    try {
      if (await _isOnline()) {
        TaskModel? onlineTask = await _onlineDatabaseService.read('users/$uid/tasks', id, (map) => TaskModel.fromMap(map));
        if (onlineTask != null) {
          final Map<String, dynamic>? existingLocalTask = await _localDatabaseService.queryById('tasks', id);
          if (existingLocalTask == null) {
            await _localDatabaseService.insert('tasks', onlineTask.toMapBaseModel());
          }
        }
      }
      final Map<String, dynamic>? map = await _localDatabaseService.queryById('tasks', id);
      if (map != null) {
        return TaskModel.fromMap(map);
      }
      else {
        return null;
      }
    } catch (e) {
      print('Error in get task: $e');
      return null;
    }
  }

  Future<List<TaskModel>> readAll(String id, String uid) async {
    try {
      final List<Map<String, dynamic>> map = await _localDatabaseService.queryAll('tasks');
      if (await _isOnline()) {
        List<TaskModel> onlineTask = await _onlineDatabaseService.readAll('users/$uid/tasks', (map) => TaskModel.fromMap(map));
        for (var task in onlineTask) {
          final Map<String, dynamic>? existingLocalTask = await _localDatabaseService.queryById('tasks', task.id!);
          if (existingLocalTask == null) {
            await _localDatabaseService.insert('tasks', task.toMapBaseModel());
          }
        }
      }
      return List.generate(map.length, (index) {
        return TaskModel.fromMap(map[index]);
      });
    } catch (e) {
      print('Error in get task: $e');
      return [];
    }
  }

  @override
  Future<void> update(TaskModel taskModel, String uid) async {
    try {
      await _localDatabaseService.update('tasks', taskModel.id!, taskModel.toMapBaseModel());
      if (await _isOnline()) {
        await _onlineDatabaseService.update('users/$uid/tasks/${taskModel.id}', taskModel);
      }
    } catch (e) {
      print('Error in update task: $e');
    }
  }

  @override
  Future<void> delete(String id, String uid) async {
    try {
      await _localDatabaseService.delete('tasks', id);
      if (await _isOnline()) {
        await _onlineDatabaseService.delete('users/$uid/tasks', id);
      }
    } catch (e) {
      print("Error in delete task: $e");
    }
  }

  Future<void> synchronize(String uid) async {
    if (await _isOnline()) {
      await _syncWithOnlineDatabase(uid);
    }
  }
}