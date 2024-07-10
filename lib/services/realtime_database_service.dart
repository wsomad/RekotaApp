import 'package:firebase_database/firebase_database.dart';
import 'package:task_management_app/interfaces/base_model.dart';

class RealtimeDatabaseService<T extends BaseModel> {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  Future<void> insert(String path, T model) async {
    try {
      await _databaseReference.child(path).child(model.id!).set(model.toMapBaseModel());
    } catch (e) {
      rethrow;
    }
  }

  Future<T?> read(String path, String id, T Function(Map<String, dynamic>) fromMap) async {
    try {
      DatabaseEvent snapshot = await _databaseReference.child(path).child(id).once();
      final event = snapshot.snapshot;
      if (event.exists) {
        return fromMap(Map<String, dynamic>.from(event.value as Map));
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<List<T>> readAll(String path, T Function(Map<String, dynamic>) fromMap) async {
    try {
      DatabaseEvent snapshot = await _databaseReference.child(path).once();
      final event = snapshot.snapshot;

      if (event.exists && event.value is Map) {
        Map<String, dynamic> data = Map<String, dynamic>.from(event.value as Map);
        return data.values.map((e) => fromMap(Map<String, dynamic>.from(e as Map))).toList();
      }
    } catch (e) {
      rethrow;
    }
    return [];
  }

  Future<void> update(String path, T model) async {
    try {
      await _databaseReference.child(path).child(model.id!).update(model.toMapBaseModel());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete(String path, String id) async {
    try {
      await _databaseReference.child(path).child(id).remove();
    } catch (e) {
      rethrow;
    }
  }
}
