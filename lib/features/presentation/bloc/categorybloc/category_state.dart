import 'package:todoapp/features/data/models/categorymodel.dart';

abstract class CategoryState {
  CategoryState();
}

class CategInitialState extends CategoryState {
  CategInitialState() : super();
}

class CategLoadingState extends CategoryState {
  List<CategoryModel> categList = [];
  int categCount = 0;
  CategLoadingState({required this.categList,required this.categCount}) : super();
}
/* class LoadPendingTaskState extends TaskState{
  LoadPendingTaskState({required this.taskList, required this.pendingList})
} */

class CategCreateState extends CategoryState {
  CategCreateState() : super();
}

class CategErrorState extends CategoryState {
  final String errormsg;
  CategErrorState({required this.errormsg}) : super();
}
/* 
//in search we will be getting searchout list passed here.
class StudentSearchState extends StudentState {
  StudentSearchState(List<StudentModel> studentlist)
      : super(studentList: studentlist); }*/

