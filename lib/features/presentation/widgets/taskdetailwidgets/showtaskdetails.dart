import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todoapp/features/presentation/bloc/taskbloc/task_event.dart';
import 'package:todoapp/features/presentation/constants/colorconstants.dart';

import 'package:todoapp/features/data/datasources/dbfunctions/repository.dart';
import 'package:todoapp/features/data/datasources/dbfunctions/taskdbrepo.dart';

import '../../bloc/taskbloc/task_bloc.dart';
import '../../bloc/taskbloc/task_state.dart';
import '../listwidget.dart';

class ShowTaskDetail extends StatefulWidget {
  final int chosenId;
  final String queryval;
  const ShowTaskDetail({super.key, this.chosenId = 0, this.queryval = ""});

  @override
  State<ShowTaskDetail> createState() => _ShowTaskDetailState();
}

class _ShowTaskDetailState extends State<ShowTaskDetail> {
  @override
  void initState() {
   // BlocProvider.of<TaskBloc>(context).add(LoadTaskEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int totalCount = 0;
    int completedTaskCount = 0;
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if(state is TaskCreateState){
           BlocProvider.of<TaskBloc>(context).add(SearchFilterTaskEvent(
            chosedId: widget.chosenId,
            queryval: widget.queryval,
          ));
        }
        if (state is SearchFilterTaskState) {
         // print(state);
          totalCount = state.filterTotalCount;
          completedTaskCount = state.filterCompletedCount;

          return Expanded(
              flex: 7,
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: ListView(
                  children: [
                    //showing filter message
                    state.filtermessage != ""
                        ? Container(
                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(state.filtermessage,
                                    style: const TextStyle(fontSize: 18))),
                          )
                        : Container(height: 15),
                    //checking to see if needed to show progressbar or not
                    state.searchEnabled == false
                        ? Stack(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                  minHeight: 8,
                                  backgroundColor: const Color(0x3300A9A6),
                                  color: primaryclr2,
                                  value: state.progressIndicatorValue),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 15),
                              child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    '$completedTaskCount/$totalCount Completed ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: primaryclr3,
                                    ),
                                  )),
                            )
                          ])
                        : Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: const Text('Search Results',
                                style: TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.underline)),
                          ),
                    ((state.searchList.isEmpty && widget.queryval != '') ||
                            (state.filterList.isEmpty &&
                                state.filtermessage != ''))
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
                                child: Align(
                                    child: Text(
                                  "No results found",
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
                                    Image.asset('assets/images/notfound.png'),
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
                                    child: Image.asset(
                                        'assets/images/happybird.png'),
                                  )
                                ],
                              )
                            : ListWidget(
                                futureList: widget.chosenId == 0
                                    ? TaskRepository.getAllData(
                                        Repository.currentUserID)
                                    : TaskRepository.fetchDataWithId(
                                        widget.chosenId,
                                        Repository.currentUserID)),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ));
        } else {
          BlocProvider.of<TaskBloc>(context).add(SearchFilterTaskEvent(
            chosedId: widget.chosenId,
            queryval: widget.queryval,
          ));
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
