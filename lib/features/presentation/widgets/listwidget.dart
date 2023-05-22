import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:todoapp/features/presentation/bloc/taskbloc/task_state.dart';


import 'package:todoapp/features/presentation/widgets/taskdetailwidgets/tasktile.dart';

import '../../data/models/taskmodel.dart';
import '../bloc/taskbloc/task_bloc.dart';
import '../bloc/taskbloc/task_event.dart';

class ListWidget extends StatefulWidget {
  final Future<List<TaskModel>> futureList;
  final String query;

  const ListWidget({super.key, required this.futureList,this.query=""});

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc,TaskState>(
      builder: (context, state) {
        if(state is SearchFilterTaskState){
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

                      if (date.isBefore(DateTime.now())) {
                        overdue = true;
                      }

                      bool ifCompleted =
                          (snapshot.data![index].isCompleted == 1)
                              ? true
                              : false;

                      if (state.filtermessage != "") {
                        if (state.filterList.contains(data.tid)) {
                          if ( state.searchEnabled) {
                            if (state.searchList
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
                        if (state.searchEnabled) {
                          if (state.searchList
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
                      if (state.filtermessage != "") {
                        if (state.filterList
                            .contains(snapshot.data![index].tid)) {
                          if (state.searchEnabled) {
                            if (state.searchList
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
                        if (state.searchEnabled) {
                          if (state.searchList
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
        }
        else{
          BlocProvider.of<TaskBloc>(context).add(SearchFilterTaskEvent(
         
          queryval: widget.query,
        )); 
        return const CircularProgressIndicator();
        }
      },
    );
  }

 /*  Future<void> deleteTask(
      String taskname, int categid, BuildContext ctx) async {
    TaskRepository.deleteData(taskname, Repository.currentUserID, categid)
        .then((value) {
      snackBarWidget(context, 'Deleted Task', dangerColor);
    }).catchError((e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    });
  } */
}
