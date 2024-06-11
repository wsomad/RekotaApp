import 'package:task_management_app/models/reminder_model.dart';
import 'package:task_management_app/services/database_service.dart';

class ReminderController {
  final DatabaseService _databaseService = DatabaseService();

  Future<void> addReminder(ReminderModel reminderModel) async {
    try {
      await _databaseService.insert('reminders', reminderModel.toJson());
    } catch (e) {
      print('Error in add reminder: $e');
    }
  }

  Future<List<ReminderModel>> getReminder() async {
    try {
      final List<Map<String, dynamic>> map = await _databaseService.queryAll('reminders');
      return List.generate(map.length, (index) {
        return ReminderModel.fromJson(map[index]);
      });
    } catch (e) {
      print('Error in get reminders: $e');
      return [];
    }
  }

  Future<void> updateReminder(ReminderModel reminderModel) async {
    try {
      await _databaseService.update('reminders', reminderModel.reminderID!, reminderModel.toJson());
    } catch (e) {
      print('Error in update reminder: $e');
    }
  }

  Future<void> deleteReminder(String reminderID) async {
    try {
      await _databaseService.delete('reminders', reminderID);
    } catch (e) {
      print('Error in delete reminder: $e');
    }
  }
}