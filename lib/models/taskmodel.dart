import 'package:sqflite/sqflite.dart';

class TaskModel {
  int? tid;
  String task_name;
  int isCompleted;
  int category_id;
  int user_id;

  TaskModel(this.task_name, this.isCompleted, this.category_id, this.user_id);

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
    //id = map['userid'] as int;
    final task_name = map['task_name'] as String;
    final isCompleted = map['isCompleted'] as int;
    final category_id = map['category_id'] as int;
    final user_id = map['user_id'] as int;

    return TaskModel(task_name, isCompleted,category_id,user_id);
  }
}
