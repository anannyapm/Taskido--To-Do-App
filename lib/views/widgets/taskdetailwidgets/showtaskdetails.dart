import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:todoapp/dbfunctions/repository.dart';
import 'package:todoapp/dbfunctions/taskdbrepo.dart';
import 'package:todoapp/views/widgets/listwidget.dart';

import '../../../viewmodel/appviewmodel.dart';

class ShowTaskDetail extends StatefulWidget {
  final int chosenId;
  const ShowTaskDetail({super.key, this.chosenId = 0});

  @override
  State<ShowTaskDetail> createState() => _ShowTaskDetailState();
}

class _ShowTaskDetailState extends State<ShowTaskDetail> {
  @override
  Widget build(BuildContext context) {
    debugPrint("Task Details of Category ID - ${widget.chosenId}");
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      int totalCount = viewModel.setCountValues(widget.chosenId)['Total']!;
      int completedTaskCount =
          viewModel.setCountValues(widget.chosenId)['Completed']!;

      return Expanded(
          flex: 7,
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: ListView(
              children: [
                viewModel.filterSelection != ""
                    ? Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(viewModel.displayFilterDetail,
                                style: const TextStyle(fontSize: 18))),
                      )
                    : Container(height: 15),
                viewModel.queryval == ''
                    ? Stack(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                              minHeight: 8,
                              backgroundColor:
                                  const Color.fromARGB(51, 0, 169, 166),
                              color: const Color(0xff00A9A5),
                              value: viewModel
                                  .progressIndicatorValue(widget.chosenId)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                '$completedTaskCount/$totalCount Completed ',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              )),
                        )
                      ])
                    : const Text('Search Result',
                        style: TextStyle(fontSize: 16)),
                (viewModel.queryResultList.isEmpty && viewModel.queryval != '')
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
                            child: Align(
                                child: Text(
                              "No results found",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            )),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Image.asset('assets/images/notfound.png'),
                          )
                        ],
                      )
                    : totalCount == 0
                        ? Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Align(
                                    child: Text(
                                  "Your task bucket is empty ;)",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                )),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child:
                                    Image.asset('assets/images/happybird.png'),
                              )
                            ],
                          )
                        : ListWidget(
                            futureList: widget.chosenId == 0
                                ? TaskRepository.getAllData(
                                    Repository.currentUserID)
                                : TaskRepository.fetchDataWithId(
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
