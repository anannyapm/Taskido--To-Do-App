import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:todoapp/dbfunctions/repository.dart';
import 'package:todoapp/dbfunctions/taskdbrepo.dart';
import 'package:todoapp/viewmodel/appviewmodel.dart';
import 'package:todoapp/views/widgets/popupdialogue.dart';
import 'package:todoapp/views/widgets/taskdetailwidgets/tasktile.dart';

import '../../../models/taskmodel.dart';

class ListWidget extends StatefulWidget {
  final Future<List<TaskModel>> futureList;

  const ListWidget({super.key, required this.futureList});

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
                    TaskModel data = snapshot.data![index];
                    DateTime date = snapshot.data![index].task_date_time;
                    bool overdue = false;

                    if (date.isAfter(DateTime.now())) {
                      overdue = true;
                    }
                    debugPrint(
                        '$overdue $date is date ${DateTime.now()} is now}');
                    bool ifCompleted =
                        (snapshot.data![index].isCompleted == 1) ? true : false;

                    //if (viewModel.filterSelection != "") {
                    debugPrint('Im here in filter');
                    if (viewModel.filterSelection.contains('Today')) {
                      DateTime today = DateTime.now();
                      if (date.day == today.day &&
                          date.month == today.month &&
                          date.year == today.year) {
                        return TaskTileWidget(
                            ifcomplete: ifCompleted,
                            data: data,
                            date: date,
                            overdue: overdue);
                      } else {
                        return Container();
                      }
                    } else if (viewModel.filterSelection.contains('Tomorrow')) {
                      DateTime tomorrow = DateTime.now().add(Duration(days: 1));
                      if (date.day == tomorrow.day &&
                          date.month == tomorrow.month &&
                          date.year == tomorrow.year) {
                        return TaskTileWidget(
                            ifcomplete: ifCompleted,
                            data: data,
                            date: date,
                            overdue: overdue);
                      } else {
                        return Container();
                      }
                    } else if (viewModel.filterSelection.contains('Custom')) {
                      //debugPrint("in custom --" +
                         // date.isAfter(viewModel.date1!).toString());
                      if (viewModel.date1 != null && viewModel.date2 != null) {
                        if (date.isAfter(viewModel.date1!) &&
                            date.isBefore(viewModel.date2!)) {
                          return TaskTileWidget(
                              ifcomplete: ifCompleted,
                              data: data,
                              date: date,
                              overdue: overdue);
                        } else {
                          return Container();
                        }
                      } else {
                        return Container();
                      }
                    }
                    //}
                    else if (viewModel.filterSelection.contains('Clear')) {
                      viewModel.filterSelection="";
                      return TaskTileWidget(
                          ifcomplete: ifCompleted,
                          data: data,
                          date: date,
                          overdue: overdue);
                    }
                    else{
                      return TaskTileWidget(
                          ifcomplete: ifCompleted,
                          data: data,
                          date: date,
                          overdue: overdue);
                    }
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
