import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todoapp/models/appviewmodel.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({super.key});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(
      builder: (context, viewModel, child) {
        return ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: ((context, index) {
            bool ifCompleted = viewModel.getTaskValue(index);
            /* if (ifCompleted == false) { */
              return ListTile(
                  horizontalTitleGap: 2,
                  leading: Checkbox(
                    
                    side: BorderSide(width: 2),
                    
                    activeColor: viewModel.primclr1,
                    value: ifCompleted,
                    onChanged: (value) {
                      setState(() {
                         print(viewModel.taskCount);
                      
                      viewModel.setTaskValue(index, value!);
                      });
                       
                      
                    },
                  ),
                  title: ifCompleted?
                  Text(viewModel.getTaskTitle(index),
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                    )):
                   Text(viewModel.getTaskTitle(index)),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.delete_outline,
                        color: Colors.black,
                      )));
            /* } else {
              return null;
            } */
          }),
          itemCount: viewModel.taskCount,
          /*  separatorBuilder: (context, index) {
              return SizedBox(height: 1);
            } */
        );
      },
    );
  }
}
