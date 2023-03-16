import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/categorymodel.dart';
import 'package:todoapp/views/screens/searchscreen.dart';

import '../../constants/iconlist.dart';
import '../../dbfunctions/categorydbrepo.dart';
import '../../viewmodel/appviewmodel.dart';

import '../widgets/taskdetailwidgets/showtaskdetails.dart';

class ScreenTasks extends StatefulWidget {
  const ScreenTasks({super.key});

  @override
  State<ScreenTasks> createState() => _ScreenTasksState();
}

class _ScreenTasksState extends State<ScreenTasks> {
  String chosenValue = '';
  int chosenID = 0;
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
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: GestureDetector(
                      onTap: () {
                        showSearch(
                          context: context,
                          delegate: ScreenSearch(),
                        );
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.search),
                  Text('\tSearch',style: TextStyle(fontSize: 18),),
                          
                        ],
                      )
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: GestureDetector(
                      onTap: () {
                        showSearch(
                          context: context,
                          delegate: ScreenSearch(),
                        );
                      },
                      child: const Icon(Icons.filter_alt_outlined),
                    ),
                  ),
                ],
              ),

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
                              onChanged: (String? newvalue) async {
                                await viewModel.addCategList();
                                setState(() {
                                  chosenValue = newvalue!;

                                  chosenID =
                                      viewModel.getCategoryId(chosenValue);
                                  viewModel.addCTaskList(chosenID);

                                  debugPrint("$chosenValue $chosenID");
                                });
                              },
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        })

                   
                    ,
                  ),
                ),
              ),

              //list

              chosenValue == ''
                  ? const ShowTaskDetail()
                  : ShowTaskDetail(chosenId: chosenID),
            ],
          ),
        )),
      );
    });
  }

  List<DropdownMenuItem<String>> dropdownItems(
      AsyncSnapshot<List<CategoryModel>> snapshot) {
    List<DropdownMenuItem<String>> menuItems;

    List<DropdownMenuItem<String>> li = [
      DropdownMenuItem(
          value: '',
          child: Wrap(
            spacing: 10,
            children: [
              const Text(
                'Select a Category',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
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
