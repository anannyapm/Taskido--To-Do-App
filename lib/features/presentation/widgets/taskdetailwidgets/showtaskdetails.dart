import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todoapp/features/presentation/constants/colorconstants.dart';

import 'package:todoapp/features/data/datasources/dbfunctions/repository.dart';
import 'package:todoapp/features/data/datasources/dbfunctions/taskdbrepo.dart';

import '../../../../viewmodel/appviewmodel.dart';
import '../listwidget.dart';


class ShowTaskDetail extends StatefulWidget {
  final int chosenId;
  const ShowTaskDetail({super.key, this.chosenId = 0});

  @override
  State<ShowTaskDetail> createState() => _ShowTaskDetailState();
}

class _ShowTaskDetailState extends State<ShowTaskDetail> {
  @override
  Widget build(BuildContext context) {
   
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
                                  const Color(0x3300A9A6),
                              color:  primaryclr2,
                              value: viewModel
                                  .progressIndicatorValue(widget.chosenId)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                '$completedTaskCount/$totalCount Completed ',
                                style:  TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: primaryclr3,
                                ),
                              )),
                        )
                      ])
                    : Container(
                      margin:  const EdgeInsets.only(top:10 ),
                      
                      child:  const Text('Search Results',
                          style: TextStyle(fontSize: 16,decoration: TextDecoration.underline)),
                    ),

                ((viewModel.queryResultList.isEmpty && viewModel.queryval != '')||(viewModel.filteredList.isEmpty && viewModel.filterSelection!=''))
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
