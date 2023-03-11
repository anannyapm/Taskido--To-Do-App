import 'package:sqflite/sqflite.dart';

class TaskModel {
  int? tid;
  final String task_name;
  int isCompleted;
  final int category_id;
  final int user_id;

  TaskModel(
      {required this.task_name,
      required this.isCompleted,
      required this.category_id,
      required this.user_id,
      this.tid});

  /* Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'userid': id,
      'username': name,
      'email': email,
      'photo': photo
    };
    return map;
  } */

  static TaskModel fromMap(Map<String, dynamic> map) {
    final tid = map['tid'] as int;
    final task_name = map['task_name'] as String;
    final isCompleted = map['isCompleted'] as int;
    final category_id = map['category_id'] as int;
    final user_id = map['user_id'] as int;

    return TaskModel(
        task_name: task_name,
        isCompleted: isCompleted,
        category_id: category_id,
        user_id: user_id,
        tid: tid);
  }
}
