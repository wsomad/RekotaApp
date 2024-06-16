import 'package:task_management_app/models/note_model.dart';
import 'package:task_management_app/services/local_database_service.dart';

class NoteController {
  final LocalDatabaseService _databaseService = LocalDatabaseService();

  Future<void> addNote(NoteModel noteModel) async {
    try {
      await _databaseService.insert('notes', noteModel.toJson());
    } catch (e) {
      print('Error in add note: $e');
    }
  }

  Future<List<NoteModel>> getNote() async {
    try {
      final List<Map<String, dynamic>> map = await _databaseService.queryAll('notes');
      return List.generate(map.length, (index) {
        return NoteModel.fromJson(map[index]);
      });
    } catch (e) {
      print('Error in get note: $e');
      return [];
    }    
  }

  Future<void> updateNote(NoteModel noteModel) async {
    try {
      await _databaseService.update('notes', noteModel.noteID!, noteModel.toJson());
    } catch (e) {
      print('Error in update note: $e');
    }
  }

  Future<void> deleteNote(String noteID) async {
    try {
      await _databaseService.delete('notes', noteID);
    } catch (e) {
      print('Error in delete note: $e');
    }
  }
}