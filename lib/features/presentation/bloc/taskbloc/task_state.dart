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
  int totalTaskCount;
  int completedCount;
  


  TaskLoadingState(
      {required this.taskList,
      required this.pendingList,
      required this.completedCount,
      required this.totalTaskCount,
     
      })
      : super();
}
/* class LoadPendingTaskState extends TaskState{
  LoadPendingTaskState({required this.taskList, required this.pendingList})
} */

class TaskCreateState extends TaskState {
  TaskCreateState() : super();
}

class TaskUpdateState extends TaskState {
  TaskUpdateState() : super();
}

class TaskDeleteState extends TaskState {
  TaskDeleteState() : super();
}

class UpdateCompletionState extends TaskState {
  UpdateCompletionState() : super();
}
class SearchFilterTaskState extends TaskState {
  List<int> filterList = [];
  List searchList = [];
  int filterTotalCount = 0;
  int filterCompletedCount = 0;
  String filtermessage;
  bool searchEnabled = false;
  double progressIndicatorValue;
  SearchFilterTaskState(
      {this.filterCompletedCount = 0,
      this.filterTotalCount = 0,
      required this.searchList,
      required this.filterList,
      this.filtermessage = "",
      this.searchEnabled = false,
      this.progressIndicatorValue=0});
}

class TaskErrorState extends TaskState {
  final String errormsg;
  TaskErrorState({required this.errormsg}) : super();
}
/* 
//in search we will be getting searchout list passed here.
class StudentSearchState extends StudentState {
  StudentSearchState(List<StudentModel> studentlist)
      : super(studentList: studentlist); }*/

