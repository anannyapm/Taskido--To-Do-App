import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todoapp/dbfunctions/repository.dart';
import 'package:todoapp/dbfunctions/taskdbrepo.dart';
import 'package:todoapp/models/appviewmodel.dart';
import 'package:todoapp/views/widgets/popupdialogue.dart';

class TaskListView extends StatefulWidget {
  final String categoryName;
  final int categoryID;
  const TaskListView(
      {super.key, required this.categoryName, required this.categoryID});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(
      builder: (context, viewModel, child) {
        return FutureBuilder(
            future: TaskRepository.fetchDataWithId(
                widget.categoryID, Repository.currentUserID),
            builder: (BuildContext context,
                AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: ((context, index) {
                    //viewModel.addCTaskList(widget.categoryID);
                    bool ifCompleted = (snapshot.data![index]['isCompleted']==1)?true:false;
                    //viewModel.getCTaskValue(index);
                    /* if (ifCompleted == false) { */
                    return //viewModel.getCategory(index) == widget.categoryName?
                        ListTile(
                            horizontalTitleGap: 2,
                            leading: Checkbox(
                              side: const BorderSide(width: 2),
                              activeColor: const Color.fromARGB(127, 0, 0, 0),
                              value: ifCompleted,
                              onChanged: (value)  {
                                setState(() {
                                  //print(viewModel
                                      //.cBasedTaskCount(widget.categoryID).toString());

                                   viewModel.updateTaskValue(
                                      snapshot.data![index]['tid'], value!, widget.categoryID);
                                });
                              },
                            ),
                            title: (ifCompleted)
                                ? Text(
                                  snapshot.data![index]['task_name'],
                                    //viewModel.getCTaskListItem(index).task_name,
                                    style: const TextStyle(
                                      color: Color.fromARGB(127, 0, 0, 0),
                                      decoration: TextDecoration.lineThrough,
                                    ))
                                : Text(snapshot.data![index]['task_name'],),
                            trailing: IconButton(
                                onPressed: () {
                                  popupDialogueBox(() async {
                                      debugPrint("delete pressed");
                                      await deleteTask(
                                          snapshot.data![index]['task_name'],
                                          widget.categoryID,
                                          context);
                                      await viewModel.addTaskList();
                                    }, context,
                                        'Do you want to delete ${snapshot.data![index]['task_name']} category?');
                                 
                                },
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.black,
                                )))
                        //: null
                        ;
                    /* } else {
                  return null;
                } */
                  }),
                  itemCount: snapshot.data!.length,//viewModel.cBasedTaskCount(widget.categoryID
                
                  /*  separatorBuilder: (context, index) {
                  return SizedBox(height: 1);
                } */
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 10,
                    );
                  },
                );
              }
              else {
                return Center(child: CircularProgressIndicator());
              }
            });
      },
    );
  }

  Future<void> deleteTask(String taskname,int categid, BuildContext ctx) async {
    /* dynamic out = await CategRepository.deleteData(categoryname);

    debugPrint(out.toString()); */

    TaskRepository.deleteData(taskname,Repository.currentUserID,categid).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Deleted Category',
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
