abstract class BaseModel {
  String? id;
  
  Map<String, dynamic> toMapBaseModel();

  factory BaseModel.fromMap(Map<String, dynamic> fromMap) {
    throw UnimplementedError();
  }
}