import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/categorymodel.dart';

import '../../constants/iconlist.dart';
import '../../dbfunctions/categorydbrepo.dart';
import '../../models/appviewmodel.dart';
import '../widgets/searchwidget.dart';
import '../widgets/taskdetailwidgets/tasklistview.dart';

class ScreenTasks extends StatefulWidget {
  const ScreenTasks({super.key});

  @override
  State<ScreenTasks> createState() => _ScreenTasksState();
}

class _ScreenTasksState extends State<ScreenTasks> {
  String chosenValue = '';
  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      //viewModel.addCategList();
      return Scaffold(
        body: SafeArea(
            child: Container(
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            children: [
              //searchbar
              searchBox(),
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
                    child: FutureBuilder(
                        future: CategRepository.getAllData(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<CategoryModel>> snapshot) {
                          
                          if (snapshot.hasData) {
                            return DropdownButton(
                              icon: const Icon(
                                FontAwesome5.chevron_down,
                                size: 15,
                                color: Colors.black,
                              ),
                              isExpanded: true,
                              underline: Container(),
                              value: chosenValue,
                              items: dropdownItems(snapshot),
                              onChanged: (String? newvalue) {
                                setState(() {
                                  chosenValue = newvalue!;
                                  print(chosenValue);
                                });
                              },
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        })

                    /*  DropdownButton(
                      icon: const Icon(
                        FontAwesome5.chevron_down,
                        size: 15,
                        color: Colors.black,
                      ),
                      isExpanded: true,
                      underline: Container(),
                      value: chosenValue,
                      items: dropdownItems,
                      onChanged: (String? newvalue) {
                        setState(() {
                          chosenValue = newvalue!;
                          print(chosenValue);
                        });
                      },
                    ) */
                    ,
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
                                child: Align(
                                    child: Text(
                                  "Your task bucket is empty ;)",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                )),
                              )
                            : TaskListView(categoryName: chosenValue),
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

  List<DropdownMenuItem<String>> dropdownItems(AsyncSnapshot<List<CategoryModel>> snapshot) {
    List<DropdownMenuItem<String>> menuItems;

    List<DropdownMenuItem<String>> li = [
      DropdownMenuItem(
        value: '',
          child: Wrap(
        spacing: 10,
        children: [
          Text(
            'Select a Category',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          )
        ],
      ))
    ];
    menuItems = [
      ...li,
      ...snapshot.data!
          .map((e) => DropdownMenuItem(
              value: e.category_name,
              child: Wrap(
                spacing: 10,
                children: [
                  IconList.Iconlist[e.category_logo_value],
                  Text(
                    e.category_name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  )
                ],
              )))
          .toList()
    ];
    return menuItems;
  }
}
