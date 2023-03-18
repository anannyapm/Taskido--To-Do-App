import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:todoapp/models/categorymodel.dart';

import 'package:todoapp/views/screens/searchscreen.dart';

import '../../constants/iconlist.dart';
import '../../dbfunctions/categorydbrepo.dart';
import '../../models/taskmodel.dart';
import '../../viewmodel/appviewmodel.dart';

import '../widgets/taskdetailwidgets/showtaskdetails.dart';


const List<String> SampleItem = ['Today', 'Tomorrow', 'Custom', 'Clear'];

class ScreenTasks extends StatefulWidget {
  const ScreenTasks({super.key});

  @override
  State<ScreenTasks> createState() => _ScreenTasksState();
}

class _ScreenTasksState extends State<ScreenTasks> {
  String chosenValue = '';
  int chosenID = 0;
  DateTime? startDate;
  DateTime? endDate;
  List<TaskModel> activeUsableList = [];
  String? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        body: SafeArea(
            child: Column(
              children: [
                Card(
                  margin: const EdgeInsets.all(0),
                  elevation: 2,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25))),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      gradient: LinearGradient(
                        begin: Alignment(1.392, 4.273),
                        end: Alignment(-2.084, -18.136),
                        colors: <Color>[
                          Color(0xff011638),
                          Color(0xff00a9a5),
                          // Color.fromARGB(255, 178, 246, 244),
                        ],
                        stops: <double>[0, 1],
                      ),
                    ),
                    child: Column(children: [
                      //searchbar

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                            child: //SearchWidget(searchID: chosenID)
                                GestureDetector(
                                    onTap: () {
                                      //viewModel.isSubmitted = true;
                                      showSearch(
                                        context: context,
                                        delegate: ScreenSearch(),
                                      );
                                    },
                                    child: Container(
                                      //decoration: BoxDecoration(border: Border.all(color: Colors.white,),borderRadius: BorderRadius.circular(10)),
                                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                      margin: const EdgeInsets.fromLTRB(
                                          10, 20, 0, 10),
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.search,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            '\tSearch',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    )),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                            child: PopupMenuButton<String>(
                              icon: const Icon(Icons.filter_alt_outlined,
                                  color: Colors.white),
                              initialValue: selectedMenu,
                              // Callback that sets the selected popup menu item.
                              onSelected: (String item) {
                                setState(() {
                                  selectedMenu = item;
                                });
                                if (selectedMenu == SampleItem[2]) {
                                  selectDateRange();
                                  viewModel.setDateFilter(startDate, endDate);
                                }

                                viewModel.setFilterSelection(selectedMenu!);
                                viewModel.addToFilteredList();
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                PopupMenuItem<String>(
                                  value: SampleItem[0],
                                  child: const Text('Today'),
                                ),
                                PopupMenuItem<String>(
                                  value: SampleItem[1],
                                  child: const Text('Tomorrow'),
                                ),
                                PopupMenuItem<String>(
                                  value: SampleItem[2],
                                  child: const Text('Custom Date'),
                                ),
                                PopupMenuItem<String>(
                                  value: SampleItem[3],
                                  child: const Text('Clear Filter'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      //Container(color: const Color.fromARGB(100, 0, 0, 0), height: 1),

                      //choicechip
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                        height: 50,
                        //margin: const EdgeInsets.only(top: 10, bottom: 20),
                        child: FutureBuilder(
                            future: CategRepository.getAllData(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<CategoryModel>> snapshot) {
                              if (snapshot.hasData) {
                                /* debugPrint(
                                    "Active list${viewModel.activeUsableList}"); */
                                List<Widget> initialchip = [
                                  ChoiceChip(
                                    label: const Text('All Tasks'),
                                    labelStyle: TextStyle(
                                        color: chosenValue == ''
                                            ? Colors.black
                                            : Colors.white),
                                    selected: chosenValue == '',
                                    shape: const StadiumBorder(
                                        side: BorderSide(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255))),
                                    backgroundColor: const Color(0xff011638),
                                    selectedColor:
                                        const Color.fromARGB(255, 255, 255, 255),
                                    elevation: 0,
                                    onSelected: (bool selected) async {
                                      await viewModel.addTaskList();
                                      /* debugPrint(
                                          "Active list${viewModel.activeUsableList}"); */
                                      setState(() {
                                        chosenValue = selected ? '' : '';
                                      });
                                    },
                                  )
                                ];
                                List<Widget> chipList = List<Widget>.generate(
                                  snapshot.data!.length,
                                  (int index) {
                                    return ChoiceChip(
                                      shape: const StadiumBorder(
                                          side: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255))),
                                      backgroundColor: const Color(0xff011638),
                                      selectedColor: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      elevation: 0,
                                      padding: const EdgeInsets.all(5),
                                      label: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconList.Iconlist[snapshot
                                              .data![index].category_logo_value],
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            snapshot.data![index].category_name,
                                            /* style: const TextStyle(
                                            color: Color.fromARGB(255, 246, 246, 246)) */
                                          )
                                        ],
                                      ),
                                      labelStyle: TextStyle(
                                          color: chosenValue ==
                                                  snapshot
                                                      .data![index].category_name
                                              ? Colors.black
                                              : Colors.white),
                                      selected: chosenValue ==
                                          snapshot.data![index].category_name,
                                      onSelected: (bool selected) async {
                                        await viewModel.addCategList();
                                        String value = selected
                                            ? snapshot.data![index].category_name
                                            : '';
                                        chosenID = viewModel.getCategoryId(value);
                                        await viewModel.addCTaskList(chosenID);
                                        //viewModel.setList(viewModel.cTaskList);
                                        //debugPrint(
                                           // "Active list${viewModel.activeUsableList}");
                                        setState(() {
                                          chosenValue = value;

                                          debugPrint("$chosenValue $chosenID");
                                        });
                                      },
                                    );
                                  },
                                ).toList();

                                List<Widget> finalChoiceList = [
                                  ...initialchip,
                                  ...chipList
                                ];

                                return Align(
                                  alignment: Alignment.centerLeft,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Wrap(
                                      spacing: 5,
                                      direction: Axis.horizontal,
                                      children: finalChoiceList,
                                    ),
                                  ),
                                );
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            }),
                      ),
                    ]),
                  ),
                ),
                // ),
                // ),

                //list
                // viewModel.isSubmitted==false?ListResult():

                chosenValue == ''
                    ? const ShowTaskDetail()
                    : ShowTaskDetail(chosenId: chosenID),
              ],
            )),
      );
    });
  }

  void selectDateRange() async {
    final DateTime? pickedStartDate = await showDatePicker(
      helpText: 'Select Start Date',
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedStartDate != null) {
      final DateTime? pickedEndDate = await showDatePicker(
        helpText: 'Select End Date',
        context: context,
        initialDate: pickedStartDate,
        firstDate: pickedStartDate,
        lastDate: DateTime(2100),
      );
      if (pickedEndDate != null) {
        setState(() {
          startDate = pickedStartDate;
          endDate = pickedEndDate;
        });
      }
    }
  }
}
