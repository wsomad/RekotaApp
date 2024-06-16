import 'package:firebase_database/firebase_database.dart';
import 'package:task_management_app/interfaces/base_model.dart';

class RealtimeDatabaseService<T extends BaseModel> {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  Future<void> insert(T model) async {
    try {
      await _databaseReference.child(model.id!).set(model.toMapBaseModel());
    } catch (e) {
      rethrow;
    }
  }

  Future<T?> read(String id, T Function(Map<String, dynamic>) fromMap) async {
    try {
      DatabaseEvent snapshot = await _databaseReference.child(id).once();
      final event = snapshot.snapshot;
      if (event.exists) {
        return fromMap(Map<String, dynamic>.from(event.value as Map));
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
