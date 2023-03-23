import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/functions/string_extensions.dart';
import 'package:todoapp/models/taskmodel.dart';

import '../../../viewmodel/appviewmodel.dart';

class UpcomingTasksCard extends StatefulWidget {
  const UpcomingTasksCard({super.key});

  @override
  State<UpcomingTasksCard> createState() => _UpcomingTasksCardState();
}

class _UpcomingTasksCardState extends State<UpcomingTasksCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(left: 25, right: 25, top: 15),
                child: const Text(
                  'Pending Tasks',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
              ),
            ),
            viewModel.pendingList.length != 0
                ? Container(
                  margin: EdgeInsets.only(left: 20),
                    height: 140,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        TaskModel item = viewModel.pendingList[index];
                        String categoryName = "";
                        for (var element in viewModel.categModelList) {
                          if (element.cid == item.category_id) {
                            categoryName = element.category_name;
                            break;
                          }
                        }
                        return Card(
                          elevation: 0,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          margin: const EdgeInsets.fromLTRB(0, 10, 20, 5),
                          child: Container(
                            //decoration: BoxDecoration(color: Color.fromARGB(26, 1, 22, 56)),
                            //decoration: BoxDecoration(gradient: LinearGradient(colors: [Color.fromARGB(27, 18, 5, 82),Color.fromARGB(55, 0, 169, 166)])),
                            decoration: BoxDecoration(gradient: LinearGradient(colors: [Color.fromARGB(12, 18, 5, 82),Color.fromARGB(33, 0, 169, 166)])),
                            padding: const EdgeInsets.only(left: 20, right: 20,top: 5,bottom: 5),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(categoryName.toTitleCase(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Color.fromARGB(255, 131, 130, 130)),),
                                  Text(item.task_name.toTitleCase(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800,color: Color.fromARGB(255, 0, 0, 0))),
                                  Row(
                                    children: [
                                      Icon(Icons.circle,
                                          size: 10,
                                          color: (item.task_date_time !=
                                                  DateTime.now())
                                              ? Colors.red
                                              : Colors.green),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(DateFormat('dd/MM/yyyy hh:mm aaa')
                                          .format(item.task_date_time),style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Color.fromARGB(255, 147, 147, 147)))
                                    ],
                                  )
                                ]),
                          ),
                        );
                      },
                      itemCount: viewModel.pendingList.length,
                    ),
                  )
                : Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.5)),
                          color: const Color.fromARGB(13, 1, 22, 56),
                          margin: const EdgeInsets.all(10),
                          child: Container(
                              /* decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xff011638),Colors.black,Color(0xff00a9a5)])

                    ), */
                              child: const Center(
                                  child: Text(
                            'Yay! No PendingTasks...',
                            style: TextStyle(color: Color(0xff011638)),
                          )))),
                    ),
                  )
          ],
        ),
      );
    });
  }
}
