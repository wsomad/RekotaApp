class ReminderModel {
  String? reminderID;
  DateTime? dateTime;
  String? taskId;

  ReminderModel({
    this.reminderID,
    this.dateTime,
    this.taskId,
  });

  Map<String, dynamic> toJson() {
    return {
      'reminderID': reminderID,
      'dateTime': dateTime?.millisecondsSinceEpoch,
      'taskId': taskId,
    };
  }

  factory ReminderModel.fromJson(Map<String, dynamic> fromJson) {
    return ReminderModel(
      reminderID: fromJson['reminderID'],
      dateTime: fromJson['dateTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(fromJson['dateTime'])
          : null,
      taskId: fromJson['taskId'],
    );
  }
}