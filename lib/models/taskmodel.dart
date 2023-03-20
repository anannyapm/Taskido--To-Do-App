class TaskModel {
  int? tid;
  final String task_name;
  int isCompleted;
  final int category_id;
  final int user_id;
  final DateTime task_date_time;
  //final DateTime task_time;

  TaskModel(
      {required this.task_name,
      required this.isCompleted,
      required this.category_id,
      required this.user_id,
      required this.task_date_time,
      // required this.task_time,
      this.tid});

  static TaskModel fromMap(Map<String, dynamic> map) {
    final tid = map['tid'] as int;
    final task_name = map['task_name'] as String;
    final isCompleted = map['isCompleted'] as int;
    final category_id = map['category_id'] as int;
    final user_id = map['user_id'] as int;
    final task_date_time = map['task_date_time'] as String;

    return TaskModel(
        task_name: task_name,
        isCompleted: isCompleted,
        category_id: category_id,
        user_id: user_id,
        task_date_time: DateTime.parse(task_date_time),
        tid: tid);
  }
}
