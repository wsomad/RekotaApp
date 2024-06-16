import 'package:task_management_app/models/task_model.dart';
import 'package:task_management_app/services/local_database_service.dart';

class TaskController {
  final LocalDatabaseService _databaseService = LocalDatabaseService();

  Future<void> addTask(TaskModel taskModel) async {
    try {
      await _databaseService.insert('tasks', taskModel.toJson());
    } catch (e) {
      print('Error in add task: $e');
    }
  }

  Future<List<TaskModel>> getTask() async {
    try {
      final List<Map<String, dynamic>> map = await _databaseService.queryAll('tasks');
      return List.generate(map.length, (index) {
        return TaskModel.fromJson(map[index]);
      });
    } catch (e) {
      print('Error in get task: $e');
      return [];
    }
  }

  Future<void> updateTask(TaskModel taskModel) async {
    try {
      await _databaseService.update('tasks', taskModel.taskID!, taskModel.toJson());
    } catch (e) {
      print('Error in update task: $e');
    }
  }

  Future<void> deleteTask(String taskID) async {
    try {
      await _databaseService.delete('tasks', taskID);
    } catch (e) {
      print("Error in delete task: $e");
    }
  }
}