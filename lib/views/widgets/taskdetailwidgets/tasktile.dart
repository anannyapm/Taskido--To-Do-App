import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/constants/colorconstants.dart';
import 'package:todoapp/functions/string_extensions.dart';
import 'package:todoapp/views/widgets/snackbar.dart';

import '../../../dbfunctions/repository.dart';
import '../../../dbfunctions/taskdbrepo.dart';
import '../../../models/taskmodel.dart';
import '../../../viewmodel/appviewmodel.dart';
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
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return ListTile(
          contentPadding: const EdgeInsets.all(0),
          horizontalTitleGap: 2,
          leading: Checkbox(
            side: const BorderSide(width: 2),
            activeColor: const Color.fromARGB(127, 0, 0, 0),
            value: widget.ifcomplete,
            onChanged: (value) async {
              viewModel.updateTaskValue(
                  widget.data.tid!, value!, widget.data.category_id);
              viewModel.addToTaskList();
            },
          ),
          title: (widget.ifcomplete)
              ? Text(widget.data.task_name.toTitleCase(),
                  style: const TextStyle(
                      color: Color(0x7E000000),
                      decoration: TextDecoration.lineThrough,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600))
              : (widget.overdue
                  ? Text(widget.data.task_name,
                      style: const TextStyle(
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.w600))
                  : RichText(
                      text: TextSpan(
                      text: widget.data.task_name,
                      style: const TextStyle(
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                      children: const [
                        TextSpan(
                            text: '\t\tOverdue',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 3, 3),
                                fontWeight: FontWeight.w500,
                                fontSize: 14))
                      ],
                    ))),
          subtitle: (widget.ifcomplete)
              ? Text(
                  DateFormat('EEE, dd/MM/yyyy hh:mm aaa').format(widget.date),
                  style: const TextStyle(
                      color: Color(0x7E000000),
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.lineThrough,
                      fontStyle: FontStyle.italic,
                      fontSize: 13))
              : Text(
                  DateFormat('EEE, dd/MM/yyyy hh:mm aaa').format(widget.date),
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
                      : viewModel.bottomSheetBuilder(
                          UpdateTaskSheetWidget(taskdata: widget.data),
                          context);
                },
                icon: const Icon(Icons.edit),
                color: widget.ifcomplete ? Color(0x7E000000) : primaryclr1,
                iconSize: 22,
              ),
              IconButton(
                onPressed: () {
                  popupDialogueBox(() async {
                    debugPrint("Delete Pressed");
                    await deleteTask(widget.data.task_name,
                        widget.data.category_id, context);
                    await viewModel.addToTaskList();
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
    });
  }

  Future<void> deleteTask(
      String taskname, int categid, BuildContext ctx) async {
    TaskRepository.deleteData(taskname, Repository.currentUserID, categid)
        .then((value) {
      snackBarWidget(context, 'Deleted Task', dangerColor);
    }).catchError((e) {
      debugPrint(e.toString());
      snackBarWidget(context, 'OOPs!!Something Went Wrong', primaryclr3);
    });
  }
}
