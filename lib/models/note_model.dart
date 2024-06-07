class NoteModel {
  String? noteID;
  String? content;
  DateTime? createdAt;
  String? taskId;

  NoteModel({
    this.noteID,
    this.content,
    this.createdAt,
    this.taskId,
  });

  // Convert NoteModel object to a Map<String, dynamic> for serialization
  Map<String, dynamic> toJson() {
    return {
      'noteID': noteID,
      'content': content,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'taskId': taskId,
    };
  }

  // Create a NoteModel object from a Map<String, dynamic> received from serialization
  factory NoteModel.fromJson(Map<String, dynamic> fromJson) {
    return NoteModel(
      noteID: fromJson['noteID'],
      content: fromJson['content'],
      createdAt: fromJson['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(fromJson['createdAt'])
          : null,
      taskId: fromJson['taskId'],
    );
  }
}