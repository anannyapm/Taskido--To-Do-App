import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/features/presentation/bloc/taskbloc/task_bloc.dart';
import 'package:todoapp/features/presentation/bloc/taskbloc/task_event.dart';
import 'package:todoapp/features/presentation/bloc/taskbloc/task_state.dart';
import 'package:todoapp/features/presentation/constants/colorconstants.dart';
import 'package:todoapp/features/presentation/extensions/string_extensions.dart';
import 'package:todoapp/features/presentation/widgets/snackbar.dart';

import '../../../data/datasources/dbfunctions/repository.dart';
import '../../../data/datasources/dbfunctions/taskdbrepo.dart';
import '../../../data/models/taskmodel.dart';
import '../../../../viewmodel/appviewmodel.dart';
import '../bottomsheetbuilder.dart';
import '../bottomsheets/updatetasksheet.dart';
import '../popupdialogue.dart';

class TaskTileWidget extends StatefulWidget {
  final bool ifcomplete;
  final TaskModel data;
  final DateTime date;
  final bool overdue;
  const TaskTileWidget(
      {super.key,
      required this.ifcomplete,
      required this.data,
      required this.date,
      required this.overdue});

  @override
  State<TaskTileWidget> createState() => _TaskTileWidgetState();
}

class _TaskTileWidgetState extends State<TaskTileWidget> {
  @override
  Widget build(BuildContext context) {
    //  return Consumer<AppViewModel>(builder: (context, viewModel, child) {
    return Tooltip(
      message: widget.data.task_name.toTitleCase(),
      child: BlocBuilder<TaskBloc, TaskState>(
        buildWhen: (previous, current) =>
            current is UpdateCompletionState &&
            previous is UpdateCompletionState,
        builder: (context, state) {
          return ListTile(
              contentPadding: const EdgeInsets.all(0),
              horizontalTitleGap: 2,
              leading: Checkbox(
                side: const BorderSide(width: 2),
                activeColor: const Color.fromARGB(127, 0, 0, 0),
                value: widget.ifcomplete,
                onChanged: (value) async {
                  BlocProvider.of<TaskBloc>(context).add(UpdateCompletionEvent(
                      categoryIndex: widget.data.category_id,
                      taskIndex: widget.data.tid!,
                      taskValue: value!));
                  BlocProvider.of<TaskBloc>(context).add(LoadTaskEvent());
                  /* viewModel.updateTaskValue(
                      widget.data.tid!, value!, widget.data.category_id);
                  viewModel.addToTaskList(); */
                },
              ),
              title: (widget.ifcomplete)
                  ? Text(widget.data.task_name.toTitleCase(),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Color(0x7E000000),
                          decoration: TextDecoration.lineThrough,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600))
                  : (!widget.overdue
                      ? Text(widget.data.task_name.toTitleCase(),
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: primaryclr3,
                              fontWeight: FontWeight.w600))
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                widget.data.task_name.toTitleCase(),
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: primaryclr3,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text('Overdue',
                                  style: TextStyle(
                                      color: dangerColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14)),
                            )
                          ],
                        )),
              subtitle: (widget.ifcomplete)
                  ? Text(
                      DateFormat('EEE, dd/MM/yyyy hh:mm aaa')
                          .format(widget.date),
                      style: const TextStyle(
                          color: Color(0x7E000000),
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.lineThrough,
                          fontStyle: FontStyle.italic,
                          fontSize: 13))
                  : Text(
                      DateFormat('EEE, dd/MM/yyyy hh:mm aaa')
                          .format(widget.date),
                      style: TextStyle(
                          color: primaryclr1,
                          fontWeight: FontWeight.w400,
                          fontSize: 13)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      widget.ifcomplete
                          ? snackBarWidget(
                              context,
                              'Task marked as Completed cannot be editted!',
                              dangerColor)
                          : bottomSheetBuilder(
                              UpdateTaskSheetWidget(taskdata: widget.data),
                              context);
                    },
                    icon: const Icon(Icons.edit),
                    color: widget.ifcomplete
                        ? const Color(0x7E000000)
                        : primaryclr1,
                    iconSize: 22,
                  ),
                  IconButton(
                    onPressed: () {
                      popupDialogueBox(() async {
                        await deleteTask(widget.data.task_name,
                            widget.data.category_id, context);
                        BlocProvider.of<TaskBloc>(context).add(LoadTaskEvent());
                      }, context,
                          'Do you want to delete ${widget.data.task_name} category?');
                    },
                    icon: Icon(
                      Icons.delete_outline,
                      color: dangerColor,
                    ),
                    iconSize: 25,
                  )
                ],
              ));
        },
      ),
    );
    //});
  }

  Future<void> deleteTask(
      String taskname, int categid, BuildContext ctx) async {
    TaskRepository.deleteData(taskname, Repository.currentUserID, categid)
        .then((value) {
      snackBarWidget(context, 'Deleted Task', dangerColor);
    }).catchError((e) {
      snackBarWidget(context, 'OOPs!!Something Went Wrong', primaryclr3);
    });
  }
}
