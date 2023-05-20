import 'package:todoapp/features/data/models/taskmodel.dart';

abstract class TaskState {
  

  TaskState();
}

class TaskInitialState extends TaskState {
  TaskInitialState() : super();
}

class TaskLoadingState extends TaskState {
  List<TaskModel> taskList = [];
  List<TaskModel> pendingList = <TaskModel>[];
  TaskLoadingState({required this.taskList, required this.pendingList})
      : super();
}
/* class LoadPendingTaskState extends TaskState{
  LoadPendingTaskState({required this.taskList, required this.pendingList})
} */

class TaskCreateState extends TaskState {
  TaskCreateState()
      : super();
}

class TaskErrorState extends TaskState {
  final String errormsg;
  TaskErrorState({required this.errormsg})
      : super();
}
/* 
//in search we will be getting searchout list passed here.
class StudentSearchState extends StudentState {
  StudentSearchState(List<StudentModel> studentlist)
      : super(studentList: studentlist); }*/

