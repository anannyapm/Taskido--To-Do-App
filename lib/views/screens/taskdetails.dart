import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/categoryclass.dart';

import '../../models/appviewmodel.dart';
import '../widgets/searchwidget.dart';
import '../widgets/taskdetailwidgets/tasklistview.dart';

class ScreenTasks extends StatefulWidget {
  const ScreenTasks({super.key});

  @override
  State<ScreenTasks> createState() => _ScreenTasksState();
}

class _ScreenTasksState extends State<ScreenTasks> {
  String _chosenValue = 'Personal';
  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        body: SafeArea(
            child: Container(
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            children: [
              //searchbar
              SearchBox(),
              Container(color: const Color.fromARGB(100, 0, 0, 0), height: 1),
              //dropdown
              Container(
                margin: const EdgeInsets.only(bottom: 10, top: 20),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            // ignore: prefer_const_constructors
                            color: Color.fromRGBO(
                                0, 0, 0, 0.507), //shadow for button
                            blurRadius: 4,
                            offset: Offset.fromDirection(
                                115 * 180 / 3.14)) //blur radius of shadow
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                      left: 20,
                      right: 20,
                    ),
                    child: DropdownButton(
                      icon: const Icon(
                        FontAwesome5.chevron_down,
                        size: 15,
                        color: Colors.black,
                      ),
                      isExpanded: true,
                      underline: Container(),
                      value: _chosenValue,
                      items: dropdownItems,
                      onChanged: (String? newvalue) {
                        setState(() {
                          _chosenValue = newvalue!;
                          print(_chosenValue);
                        });
                      },
                    ),
                  ),
                ),
              ),

              //list
              Expanded(
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
                                    value: viewModel.taskCount == 0
                                        ? 0
                                        : (viewModel.completedCount) /
                                            viewModel.taskCount),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      '${viewModel.completedCount}/${viewModel.taskCount} Completed ',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    )),
                              )
                            ]),

                        viewModel.taskCount == 0
                            ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Align(child: Text("Your task bucket is empty ;)",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),)),
                            )
                            : const TaskListView(),
                        const SizedBox(
                          height: 30,
                        ),

                        //CompletedListView(),
                      ],
                    ),
                  ))
            ],
          ),
        )),
      );
    });
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = List.generate(
      categoryList.length,
      (index) => DropdownMenuItem(
          value: categoryList[index].taskName,
          child: Wrap(
            spacing: 10,
            children: [
              categoryList[index].taskIcon,
              Text(
                categoryList[index].taskName,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              )
            ],
          )),
    ) /* [
    DropdownMenuItem(child: Wrap(children: [categoryList[0].taskIcon,Text(categoryList[0].taskName,)],),value: "Category 1"),
    DropdownMenuItem(child: Text("Canada"),value: "Canada"),
    DropdownMenuItem(child: Text("Brazil"),value: "Brazil"),
    DropdownMenuItem(child: Text("England"),value: "England"),
  ] */
        ;
    return menuItems;
  }
}
