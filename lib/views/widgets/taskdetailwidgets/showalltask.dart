import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/dbfunctions/categorydbrepo.dart';
import 'package:todoapp/dbfunctions/repository.dart';
import 'package:todoapp/views/widgets/taskdetailwidgets/pendinglistview.dart';
import 'package:todoapp/views/widgets/taskdetailwidgets/tasklistview.dart';

import '../../../models/appviewmodel.dart';

class ShowAllTaskDetail extends StatefulWidget {
  
  const ShowAllTaskDetail(
      {super.key});

  @override
  State<ShowAllTaskDetail> createState() => _ShowAllTaskDetailState();
}

class _ShowAllTaskDetailState extends State<ShowAllTaskDetail> {


  @override
  Widget build(BuildContext context) {
    
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return Expanded(
          flex: 7,
          child: Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: ListView(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Stack(
                    //margin: EdgeInsets.all(10),
                    children: [
                      
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                            minHeight: 8,
                            backgroundColor:
                                const Color.fromARGB(51, 0, 169, 166),
                            color: const Color(0xff00A9A5),
                            value: viewModel.totalTaskCount ==
                                    0
                                ? 0
                                : (viewModel.completedCount /
                                    viewModel.totalTaskCount)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              '${viewModel.completedCount} / ${viewModel.totalTaskCount} Completed',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            )),
                      )
                    ]),

                    Text('All Tasks',style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
              
                viewModel.totalTaskCount == 0
                    ? Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Align(
                            child: Text(
                          "Your task bucket is empty ;)",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        )),
                      )
                    : PendingTotalList(),
                const SizedBox(
                  height: 30,
                ),

                //CompletedListView(),
              ],
            ),
          ));
    });
  }

  /* Future<int> getCategoryID(String chosenCategID) async {
    final List<Map<String, dynamic>> cidOutput =
        await CategRepository.fetchData(chosenCategID);
    return cidOutput[0]['cid'];
  } */
}
