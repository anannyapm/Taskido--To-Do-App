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
                          (snapshot.data![index].isCompleted == 1)
                              ? true
                              : false;

                      /* if (viewModel.filterSelection == "" &&
                        viewModel.query.isEmpty) {
                      return TaskTileWidget(
                          ifcomplete: ifCompleted,
                          data: data,
                          date: date,
                          overdue: overdue);
                    } else if (viewModel.filterSelection != "" &&
                        viewModel.query.isNotEmpty) {
                      if (viewModel.filteredList.contains(data.tid) &&
                          viewModel.queryResultList.contains(data.task_name)) {
                        return TaskTileWidget(
                            ifcomplete: ifCompleted,
                            data: data,
                            date: date,
                            overdue: overdue);
                      } else {
                        return Container();
                      }
                    } else {
                      if (viewModel.filteredList.contains(data.tid) ||
                          viewModel.queryResultList.contains(data.task_name)) {
                        return TaskTileWidget(
                            ifcomplete: ifCompleted,
                            data: data,
                            date: date,
                            overdue: overdue);
                      } else {
                        return Container();
                      }
                    } */

                      if (viewModel.filterSelection != "") {
                        debugPrint('Im here in filter');

                        if (viewModel.filteredList.contains(data.tid)) {
                          if (viewModel.queryval != '') {
                            if (viewModel.queryResultList
                                .contains(data.task_name)) {
                              return TaskTileWidget(
                                  ifcomplete: ifCompleted,
                                  data: data,
                                  date: date,
                                  overdue: overdue);
                            } else {
                              return Container();
                            }
                          }

                          //else case
                          return TaskTileWidget(
                              ifcomplete: ifCompleted,
                              data: data,
                              date: date,
                              overdue: overdue);
                        } else {
                          return Container();
                        }
                      } else {
                        if (viewModel.queryval != '') {
                          if (viewModel.queryResultList
                              .contains(data.task_name)) {
                            return TaskTileWidget(
                                ifcomplete: ifCompleted,
                                data: data,
                                date: date,
                                overdue: overdue);
                          } else {
                            return Container();
                          }
                        }

                        return TaskTileWidget(
                            ifcomplete: ifCompleted,
                            data: data,
                            date: date,
                            overdue: overdue);
                      }
                    }),
                    itemCount: snapshot.data!.length,
                    separatorBuilder: (context, index) {
                      if (viewModel.filterSelection != "") {
                        if (viewModel.filteredList
                            .contains(snapshot.data![index].tid)) {
                          if (viewModel.queryval != '') {
                            if (viewModel.queryResultList
                                .contains(snapshot.data![index].task_name)) {
                              return const Divider(
                                thickness: 1,
                                height: 5,
                              );
                            } else {
                              return Container();
                            }
                          }
                          return const Divider(
                            thickness: 1,
                            height: 5,
                          );
                        } else {
                          return Container();
                        }
                      } else {
                        if (viewModel.queryval != '') {
                          if (viewModel.queryResultList
                              .contains(snapshot.data![index].task_name)) {
                            return const Divider(
                              thickness: 1,
                              height: 5,
                            );
                          }
                        }

                        return Container();
                      }
                    });
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            });
      },
    );
  }

  Future<void> deleteTask(
      String taskname, int categid, BuildContext ctx) async {
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
