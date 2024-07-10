import 'package:task_management_app/interfaces/base_model.dart';

abstract class BaseController<T extends BaseModel> {
  Future<void> create(T model, String uid);
  Future<T?> read(String id, String uid);
  Future<void> update(T model, String uid);
  Future<void> delete(String id, String uid);
}