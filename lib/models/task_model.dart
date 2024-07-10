import 'package:task_management_app/interfaces/base_model.dart';

class TaskModel implements BaseModel{
  String? taskID;
  String? title;
  String? description;
  DateTime? dateCreated;
  DateTime? dueDate;
  String? priority;
  bool? isCompleted;

  TaskModel({
    this.taskID,
    this.title,
    this.description,
    this.dateCreated,
    this.dueDate,
    this.priority,
    this.isCompleted,
  });

  @override
  String? get id => taskID;

  Map<String, dynamic> toMap() {
    return {
      'id': taskID,
      'title': title,
      'description': description,
      'dateCreated': dateCreated?.millisecondsSinceEpoch,
      'dueDate': dueDate?.millisecondsSinceEpoch,
      'priority': priority,
      'isCompleted': isCompleted,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> fromJson) {
    return TaskModel(
      taskID: fromJson['taskID'],
      title: fromJson['title'],
      description: fromJson['description'],
      dateCreated: fromJson['dateCreated'] != null
          ? DateTime.fromMillisecondsSinceEpoch(fromJson['dateCreated'])
          : null,
      dueDate: fromJson['dueDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(fromJson['dueDate'])
          : null,
      priority: fromJson['priority'],
      isCompleted: fromJson['isCompleted'],
    );
  }
  
  @override
  Map<String, dynamic> toMapBaseModel() {
    return toMap();
  }
}