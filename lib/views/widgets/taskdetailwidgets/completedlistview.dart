/* import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todoapp/models/appviewmodel.dart';

class CompletedListView extends StatefulWidget {
  const CompletedListView({super.key});

  @override
  State<CompletedListView> createState() => _CompletedListViewState();
}

class _CompletedListViewState extends State<CompletedListView> {

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(
      builder: (context, viewModel, child) {
        return ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: ((context, index) {
            bool ifCompleted = viewModel.getTaskValue(index);
            //if (ifCompleted == true) {
              return ListTile(
                horizontalTitleGap: 2,
                leading: Checkbox(
                  /* shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)), */
                  side: BorderSide(width: 2),
                  //checkColor: viewModel.primclr1,
                  activeColor: viewModel.primclr1,
                  value: ifCompleted,
                  onChanged:null,
                   /* (value) {
                    
                      setState(() {
                        print(viewModel.taskCount);
                        viewModel.setTaskValue(index, value!);
                      });
                   
                  }, */
                ),
                title: Text(viewModel.getTaskTitle(index),
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                    )),
                /* trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.delete_outline,
                        color: Colors.black,
                      )) */
              );
            //} else {
              return null;
            //}
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
 */