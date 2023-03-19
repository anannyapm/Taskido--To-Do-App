/* import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/dbfunctions/taskdbrepo.dart';
import 'package:todoapp/views/widgets/taskdetailwidgets/tasktile.dart';

import '../../dbfunctions/repository.dart';
import '../../viewmodel/appviewmodel.dart';
import '../../models/taskmodel.dart';
import '../widgets/popupdialogue.dart';

class ScreenSearch extends SearchDelegate {
  // first override to clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  //to pop out of the search menu
  @override
  Widget buildLeading(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      // TODO: implement buildLeading
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null); // for closing the search page and going back
        },
      );
    });
  }

//to show query result
  @override
  Widget buildResults(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return searchList(context);
    });
  }

  //to show the querying process ie suggestions at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return searchList(context);
    });
  }

  Widget searchList(BuildContext context) {
    return Consumer<AppViewModel>(
      builder: (context, viewModel, child) {
        return FutureBuilder(
            future: TaskRepository.getAllData(),
            builder: (BuildContext context,
                AsyncSnapshot<List<TaskModel>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: ((context, index) {
                    final data = snapshot.data![index];
                    String taskName = data.task_name;
                    DateTime date = snapshot.data![index].task_date_time;
                    bool overdue = false;

                    if (date.isAfter(DateTime.now())) {
                      overdue = true;
                    }
                    debugPrint(
                        '$overdue $date is date ${DateTime.now()} is now}');
                    bool ifCompleted =
                        (snapshot.data![index].isCompleted == 1) ? true : false;

                    if ((taskName.toLowerCase())
                        .contains((query.trim()).toLowerCase())) {
                      return TaskTileWidget(
                          ifcomplete: ifCompleted,
                          data: data,
                          date: date,
                          overdue: overdue);
                    } else {
                      return Container();
                    }
                  }),
                  itemCount: snapshot.data!.length,
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



//call in task

    /* GestureDetector(
                                    onTap: () {
                                      //viewModel.isSubmitted = true;
                                      showSearch(
                                        context: context,
                                        delegate: ScreenSearch(),
                                      );
                                    },
                                    child: Container(
                                      //decoration: BoxDecoration(border: Border.all(color: Colors.white,),borderRadius: BorderRadius.circular(10)),
                                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                      margin: const EdgeInsets.fromLTRB(
                                          10, 20, 0, 10),
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.search,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            '\tSearch',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    )), */ */