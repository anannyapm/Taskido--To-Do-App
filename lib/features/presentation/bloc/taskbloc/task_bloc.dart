import 'package:bloc/bloc.dart';
import 'package:todoapp/features/data/repositories/taskfunctions.dart';
import 'package:todoapp/features/presentation/bloc/taskbloc/task_event.dart';
import 'package:todoapp/features/presentation/bloc/taskbloc/task_state.dart';

import '../../../data/models/taskmodel.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  List<TaskModel> taskModelList = <TaskModel>[];

  TaskBloc() : super(TaskInitialState()) {
    on<LoadTaskEvent>((event, emit) {
      final taskData = TaskFunctionRepo.getTaskList();
      if (taskData == null) {
        emit(TaskErrorState(errormsg: "Data Fetch Error"));
      } else {
        emit(TaskLoadingState(
            taskList: taskData, pendingList: TaskFunctionRepo.pendingList));
      }
    });
    on<AddTaskEvent>((event, emit) async {
      final output = await TaskFunctionRepo.addTask(
          event.taskname, event.categId, event.date, event.time);
      if (output != true) {
        emit(TaskErrorState(
            errormsg: "Oh Snap! Looks like task already exist!"));
      } else {
                emit(TaskCreateState());

      }
    });

    /* on<UpdateTaskEvent>(
      (event, emit) {

      },
    ); */
  }
}
