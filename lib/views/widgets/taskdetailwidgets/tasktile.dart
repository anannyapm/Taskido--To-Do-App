import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../dbfunctions/repository.dart';
import '../../../dbfunctions/taskdbrepo.dart';
import '../../../models/taskmodel.dart';
import '../../../viewmodel/appviewmodel.dart';
import '../popupdialogue.dart';

class TaskTileWidget extends StatefulWidget {
  final bool ifcomplete;
  final TaskModel data;
  final DateTime date;
  final bool overdue;
  const TaskTileWidget(
      {super.key, required this.ifcomplete, required this.data,required this.date,required this.overdue});

  @override
  State<TaskTileWidget> createState() => _TaskTileWidgetState();
}

class _TaskTileWidgetState extends State<TaskTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return ListTile(
          contentPadding: EdgeInsets.all(0),
          horizontalTitleGap: 2,
          leading: Checkbox(
            side: const BorderSide(width: 2),
            activeColor: const Color.fromARGB(127, 0, 0, 0),
            value: widget.ifcomplete,
            onChanged: (value) async {
              viewModel.updateTaskValue(
                  widget.data.tid!, value!, widget.data.category_id);
              viewModel.addTaskList();
            },
          ),
          title: (widget.ifcomplete)
              ? Text(widget.data.task_name,
                  //viewModel.getCTaskListItem(index).task_name,
                  style: const TextStyle(
                      color: Color.fromARGB(127, 0, 0, 0),
                      decoration: TextDecoration.lineThrough,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600))
              : (widget.overdue
                  ? Text(widget.data.task_name,
                      //viewModel.getCTaskListItem(index).task_name,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w600))
                  : RichText(
                      text: TextSpan(
                      text: '${widget.data.task_name}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
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
                      //viewModel.getCTaskListItem(index).task_name,
                    ))),
          subtitle: (widget.ifcomplete)
              ? Text(DateFormat('EEE, dd/MM/yyyy hh:mm aaa').format(widget.date),
                  //viewModel.getCTaskListItem(index).task_name,
                  style: const TextStyle(
                      color: Color.fromARGB(127, 0, 0, 0),
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.lineThrough,
                      fontStyle: FontStyle.italic,
                      fontSize: 13))
              : Text(DateFormat('EEE, dd/MM/yyyy hh:mm aaa').format(widget.date),
                  style: const TextStyle(
                      color: Color(0xff011638),
                      fontWeight: FontWeight.w400,
                      fontSize: 13)),
          trailing: IconButton(
              onPressed: () {
                popupDialogueBox(() async {
                  debugPrint("delete pressed");
                  await deleteTask(widget.data.task_name,
                      widget.data.category_id, context);
                  await viewModel.addTaskList();
                }, context,
                    'Do you want to delete ${widget.data.task_name} category?');
              },
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.red,
              )));
    });
    
  }
  Future<void> deleteTask(
      String taskname, int categid, BuildContext ctx) async {
    /* dynamic out = await CategRepository.deleteData(categoryname);

    debugPrint(out.toString()); */

    TaskRepository.deleteData(taskname, Repository.currentUserID, categid)
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Deleted Task',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        padding: EdgeInsets.all(20),
      ));
    }).catchError((e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    });
  }
}
