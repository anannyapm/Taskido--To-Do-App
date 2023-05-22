import 'package:bloc/bloc.dart';
import 'package:todoapp/features/data/repositories/taskfunctions.dart';
import 'package:todoapp/features/presentation/bloc/taskbloc/task_event.dart';
import 'package:todoapp/features/presentation/bloc/taskbloc/task_state.dart';

import '../../../data/models/taskmodel.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  List<TaskModel> taskModelList = <TaskModel>[];

  TaskBloc() : super(TaskInitialState()) {
    on<LoadTaskEvent>((event, emit) async {
      final taskData = await TaskFunctionRepo.getTaskList();
      if (taskData == null) {
        emit(TaskErrorState(errormsg: "Data Fetch Error"));
      } else {
        emit(TaskLoadingState(
            taskList: taskData,
            pendingList: TaskFunctionRepo.pendingList,
            completedCount: TaskFunctionRepo.completedCount,
            totalTaskCount: TaskFunctionRepo.totalTaskCount));
      }
    });
    on<AddTaskEvent>((event, emit) async {
      bool output = await TaskFunctionRepo.addTask(
          event.taskname, event.categId, event.date, event.time);
      if (output != true) {
        emit(TaskErrorState(
            errormsg: "Oh Snap! Looks like task already exist!"));
      } else {
        emit(TaskCreateState());
      }
    });
    on<SearchFilterTaskEvent>((event, emit) async {
      List searchlist = [];
      List<int> filterlist = [];
      bool enable = false;

      if (event.queryval != "") {
        searchlist = TaskFunctionRepo.addToQueryList(event.queryval);
        enable = true;
      }
      if (event.filterkey != "") {
        TaskFunctionRepo.setDateFilter(event.date1, event.date2);
        TaskFunctionRepo.setFilterSelection(event.filterkey);
        filterlist = TaskFunctionRepo.addToFilteredList();
      }

      emit(SearchFilterTaskState(
          searchEnabled: enable,
          progressIndicatorValue:
              TaskFunctionRepo.progressIndicatorValue(event.chosedId),
          filtermessage: TaskFunctionRepo.displayFilterDetail,
          filterCompletedCount:
              TaskFunctionRepo.setCountValues(event.chosedId)['Completed']!,
          filterTotalCount:
              TaskFunctionRepo.setCountValues(event.chosedId)['Total']!,
          searchList: searchlist,
          filterList: filterlist));
    });

    on<UpdateTaskEvent>((event, emit) async {
      final List output = await TaskFunctionRepo.updateTaskData(
          event.taskName, event.taskobject, event.date, event.time);
      if (output.isNotEmpty) {
        emit(TaskErrorState(errormsg: "Oh Snap!Something Went Wrong!"));
      } else {
        emit(TaskUpdateState());
        
      }
    });
    on<UpdateCompletionEvent>(
      (event, emit) async {
        await TaskFunctionRepo.updateCompletionStatus(
            event.taskIndex, event.taskValue, event.categoryIndex);

        emit(UpdateCompletionState());
      },
    );
  }
}
