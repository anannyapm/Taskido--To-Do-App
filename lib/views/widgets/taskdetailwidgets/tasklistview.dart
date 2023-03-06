import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todoapp/models/appviewmodel.dart';
import 'package:todoapp/views/widgets/popupdialogue.dart';

class TaskListView extends StatefulWidget {
  String categoryName;
  TaskListView({super.key, required this.categoryName});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(
      builder: (context, viewModel, child) {
        return ListView.separated(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemBuilder: ((context, index) {
            bool ifCompleted = viewModel.getTaskValue(index);
            /* if (ifCompleted == false) { */
            return //viewModel.getCategory(index) == widget.categoryName?
                ListTile(
                    horizontalTitleGap: 2,
                    leading: Checkbox(
                      side: const BorderSide(width: 2),
                      activeColor: const Color.fromARGB(127, 0, 0, 0),
                      value: ifCompleted,
                      onChanged: (value) {
                        setState(() {
                          print(viewModel.taskCount);

                          viewModel.setTaskValue(index, value!);
                        });
                      },
                    ),
                    title: (ifCompleted)
                        ? Text(viewModel.getTaskTitle(index),
                            style: const TextStyle(
                              color: Color.fromARGB(127, 0, 0, 0),
                              decoration: TextDecoration.lineThrough,
                            ))
                        : Text(viewModel.getTaskTitle(index)),
                    trailing: IconButton(
                        onPressed: () {
                          popupDialogueBox(() {}, context,
                              'Delete task ${viewModel.getTaskTitle(index)}?');
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
          itemCount: viewModel.taskCount,
          /*  separatorBuilder: (context, index) {
              return SizedBox(height: 1);
            } */
          separatorBuilder: (context, index) {
            return const Divider(
              height: 10,
            );
          },
        );
      },
    );
  }
}
