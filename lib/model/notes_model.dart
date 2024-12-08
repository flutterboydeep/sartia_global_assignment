import 'package:hive/hive.dart';
part 'notes_model.g.dart';
// Make sure this line is present

@HiveType(typeId: 0)
class NotesModel extends HiveObject {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? userid;

  @HiveField(2)
  final String? title;

  @HiveField(3)
  final String? content;

  @HiveField(4)
  final DateTime? date;

  NotesModel({
    this.id,
    this.userid,
    this.title,
    this.content,
    this.date,
  });

  factory NotesModel.fromMap(Map<String, dynamic> map) {
    return NotesModel(
      id: map['id'] as String?,
      userid: map['userid'] as String?,
      title: map['title'] as String?,
      content: map['content'] as String?,
      date: map['date'] != null ? DateTime.tryParse(map['date']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userid': userid,
      'title': title,
      'content': content,
      'date': date?.toIso8601String(),
    };
  }
}
