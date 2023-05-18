import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/features/presentation/constants/colorconstants.dart';
import 'package:todoapp/features/presentation/extensions/string_extensions.dart';
import 'package:todoapp/features/data/models/taskmodel.dart';

import '../../../../viewmodel/appviewmodel.dart';


class UpcomingTasksCard extends StatefulWidget {
  const UpcomingTasksCard({super.key});

  @override
  State<UpcomingTasksCard> createState() => _UpcomingTasksCardState();
}

class _UpcomingTasksCardState extends State<UpcomingTasksCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(left: 25, right: 25, top: 20),
                child: const Text(
                  'Today\'s Pending Tasks',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
              ),
            ),
            viewModel.pendingList.isNotEmpty
                ? Container(
                    margin: const EdgeInsets.only(left: 20),
                    height: 145,
                    
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
                            width: 200,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(colors: [
                              Color.fromARGB(12, 18, 5, 82),
                              Color.fromARGB(33, 0, 169, 166)
                            ])),
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 5, bottom: 5),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    categoryName.toTitleCase(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            Color.fromARGB(255, 131, 130, 130)),
                                  ),
                                  Text(item.task_name.toTitleCase(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                          color: Color.fromARGB(255, 0, 0, 0))),
                                  Row(
                                    children: [
                                      Icon(Icons.circle,
                                          size: 10,
                                          color: (item.task_date_time
                                                  .isBefore(DateTime.now()))
                                              ?dangerColor
                                              : successColor),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          DateFormat('dd/MM/yyyy hh:mm aaa')
                                              .format(item.task_date_time),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromARGB(
                                                  255, 147, 147, 147)))
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
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: Center(
                              child: Text(
                            'Yay! No PendingTasks',
                            style: TextStyle(color: primaryclr1,fontSize: 16),
                          )),
                      
                    ),
                  )
          ],
        ),
      );
    });
  }
}
