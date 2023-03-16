import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:todoapp/dbfunctions/repository.dart';
import 'package:todoapp/dbfunctions/taskdbrepo.dart';
import 'package:todoapp/viewmodel/appviewmodel.dart';
import 'package:todoapp/views/widgets/popupdialogue.dart';

import '../../../models/taskmodel.dart';

class ListWidget extends StatefulWidget {
  final Future<List<TaskModel>> futureList;
  const ListWidget({super.key,required this.futureList});

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(
      builder: (context, viewModel, child) {
        return FutureBuilder(
            future: widget.futureList,
            builder: (BuildContext context,
                AsyncSnapshot<List<TaskModel>> snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: ((context, index) {
                    DateTime date = snapshot.data![index].task_date_time;
                    bool overdue = false;

                    if (date.isAfter(DateTime.now())) {
                      overdue = true;
                    }
                    debugPrint(
                        '$overdue $date is date ${DateTime.now()} is now}');
                    bool ifCompleted =
                        (snapshot.data![index].isCompleted == 1) ? true : false;

                    return ListTile(
                        //contentPadding: EdgeInsets.all(0),
                        horizontalTitleGap: 2,
                        leading: Checkbox(
                          side: const BorderSide(width: 2),
                          activeColor: const Color.fromARGB(127, 0, 0, 0),
                          value: ifCompleted,
                          onChanged: (value) async {
                            viewModel.updateTaskValue(
                                snapshot.data![index].tid!,
                                value!,
                                snapshot.data![index].category_id);
                            viewModel.addTaskList();
                            /* setState(() {
                                  

                                   
                                }); */
                          },
                        ),
                        title: (ifCompleted)
                            ? Text(snapshot.data![index].task_name,
                                //viewModel.getCTaskListItem(index).task_name,
                                style: const TextStyle(
                                    color: Color.fromARGB(127, 0, 0, 0),
                                    decoration: TextDecoration.lineThrough,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w600))
                            : (overdue
                                ? Text(snapshot.data![index].task_name,
                                    //viewModel.getCTaskListItem(index).task_name,
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.w600))
                                : RichText(
                                    text: TextSpan(
                                    text: '${snapshot.data![index].task_name}',
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                    children: const [
                                      TextSpan(
                                          text: '\t\tOverdue',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 3, 3),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14))
                                    ],
                                    //viewModel.getCTaskListItem(index).task_name,
                                  ))),
                        subtitle: (ifCompleted)
                            ? Text(
                                DateFormat('EEE, dd/MM/yyyy hh:mm aaa')
                                    .format(date),
                                //viewModel.getCTaskListItem(index).task_name,
                                style: const TextStyle(
                                    color: Color.fromARGB(127, 0, 0, 0),
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.lineThrough,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 13))
                            : Text(
                                DateFormat('EEE, dd/MM/yyyy hh:mm aaa')
                                    .format(date),
                                style: const TextStyle(
                                    color: Color(0xff011638),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13)),
                        trailing: IconButton(
                            onPressed: () {
                              popupDialogueBox(() async {
                                debugPrint("delete pressed");
                                await deleteTask(
                                    snapshot.data![index].task_name,
                                    snapshot.data![index].category_id,
                                    context);
                                await viewModel.addTaskList();
                              }, context,
                                  'Do you want to delete ${snapshot.data![index].task_name} category?');
                            },
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            )));
                  }),
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (context, index) {
                    return const Divider(
                      thickness: 1,
                      height: 10,
                    );
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            });
      },
    );
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
