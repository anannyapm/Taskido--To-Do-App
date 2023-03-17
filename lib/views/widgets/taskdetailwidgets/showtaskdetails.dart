import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:todoapp/dbfunctions/repository.dart';
import 'package:todoapp/dbfunctions/taskdbrepo.dart';
import 'package:todoapp/views/widgets/listwidget.dart';

import '../../../viewmodel/appviewmodel.dart';

class ShowTaskDetail extends StatefulWidget {
  //final String chosenVal;
  final int chosenId;
  const ShowTaskDetail({super.key, this.chosenId = 0});

  @override
  State<ShowTaskDetail> createState() => _ShowTaskDetailState();
}

class _ShowTaskDetailState extends State<ShowTaskDetail> {
  @override
  Widget build(BuildContext context) {
    debugPrint("In show task details of ${widget.chosenId}");
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      int totalTaskCount = widget.chosenId == 0
          ? viewModel.totalTaskCount
          : viewModel.cBasedTaskCount(widget.chosenId);
      int completedCount = widget.chosenId == 0
          ? viewModel.completedCount
          : viewModel.cBasedCompletdTaskCount(widget.chosenId);
      return Expanded(
          flex: 7,
          child: Container(
            
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: ListView(
              children: [
                Stack(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                        minHeight: 8,
                        backgroundColor: const Color.fromARGB(51, 0, 169, 166),
                        color: const Color(0xff00A9A5),
                        value: viewModel.progressIndicatorValue(widget.chosenId)
                        /* viewModel.cBasedTaskCount(widget.chosenId) == 0
                            ? 0
                            : (viewModel
                                    .cBasedCompletdTaskCount(widget.chosenId)) /
                                viewModel.cBasedTaskCount(widget.chosenId) */
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          '$completedCount/$totalTaskCount Completed ',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        )),
                  )
                ]),
                totalTaskCount == 0
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Align(
                            child: Text(
                          "Your task bucket is empty ;)",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        )),
                      )
                      //find a way to use usablelist
                    : ListWidget(
                        futureList: 
                        widget.chosenId==0?TaskRepository.getAllData(): TaskRepository.fetchDataWithId(
                            widget.chosenId, Repository.currentUserID)),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ));
    });
  }
}
