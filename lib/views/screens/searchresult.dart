/* import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../dbfunctions/repository.dart';
import '../../dbfunctions/taskdbrepo.dart';
import '../../viewmodel/appviewmodel.dart';
import '../widgets/popupdialogue.dart';

class ListResult extends StatefulWidget {
  
  const ListResult({super.key});

  @override
  State<ListResult> createState() => _ListResultState();
}

class _ListResultState extends State<ListResult> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: ((context, index) {
          final data = viewModel.activeUsableList[index];
          String taskName = data.task_name;
          DateTime date = viewModel.activeUsableList[index].task_date_time;
          bool overdue = false;

          if (date.isAfter(DateTime.now())) {
            overdue = true;
          }
          debugPrint('$overdue $date is date ${DateTime.now()} is now}');
          bool ifCompleted =
              (viewModel.activeUsableList[index].isCompleted == 1)
                  ? true
                  : false;

          return ListTile(
              //contentPadding: EdgeInsets.all(0),
              horizontalTitleGap: 2,
              leading: Checkbox(
                side: const BorderSide(width: 2),
                activeColor: const Color.fromARGB(127, 0, 0, 0),
                value: ifCompleted,
                onChanged: (value) async {
                  viewModel.updateTaskValue(
                      data.tid!, value!, data.category_id);
                  viewModel.addTaskList();
                },
              ),
              title: (ifCompleted)
                  ? Text(data.task_name,
                      //viewModel.getCTaskListItem(index).task_name,
                      style: const TextStyle(
                          color: Color.fromARGB(127, 0, 0, 0),
                          decoration: TextDecoration.lineThrough,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600))
                  : (overdue
                      ? Text(data.task_name,
                          //viewModel.getCTaskListItem(index).task_name,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w600))
                      : RichText(
                          text: TextSpan(
                          text: '${data.task_name}',
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
              subtitle: (ifCompleted)
                  ? Text(DateFormat('EEE, dd/MM/yyyy hh:mm aaa').format(date),
                      //viewModel.getCTaskListItem(index).task_name,
                      style: const TextStyle(
                          color: Color.fromARGB(127, 0, 0, 0),
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.lineThrough,
                          fontStyle: FontStyle.italic,
                          fontSize: 13))
                  : Text(DateFormat('EEE, dd/MM/yyyy hh:mm aaa').format(date),
                      style: const TextStyle(
                          color: Color(0xff011638),
                          fontWeight: FontWeight.w400,
                          fontSize: 13)),
              trailing: IconButton(
                  onPressed: () {
                    popupDialogueBox(() async {
                      debugPrint("delete pressed");
                      await deleteTask(
                          data.task_name, data.category_id, context);
                      await viewModel.addTaskList();
                    }, context,
                        'Do you want to delete ${data.task_name} category?');
                  },
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  )));
        }),
        itemCount: viewModel.activeUsableList.length,
      );
    });
  }

  Future<void> deleteTask(
      String taskname, int categid, BuildContext ctx) async {
    /* dynamic out = await CategRepository.deleteData(categoryname);

    debugPrint(out.toString()); */

    TaskRepository.deleteData(taskname, Repository.currentUserID, categid)
        .then((value) {
      ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
        content: Text(
          'Deleted Task',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        padding: EdgeInsets.all(20),
      ));
    }).catchError((e) {
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    });
  }
}
 */