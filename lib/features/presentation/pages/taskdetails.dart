import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';
import 'package:todoapp/features/data/repositories/categoryfunctions.dart';
import 'package:todoapp/features/presentation/bloc/taskbloc/task_bloc.dart';
import 'package:todoapp/features/presentation/extensions/string_extensions.dart';

import 'package:todoapp/features/data/models/categorymodel.dart';

import 'package:todoapp/features/presentation/widgets/search.dart';

import '../bloc/categorybloc/category_bloc.dart';
import '../bloc/categorybloc/category_event.dart';
import '../bloc/taskbloc/task_event.dart';
import '../constants/colorconstants.dart';
import '../constants/iconlist.dart';
import '../../data/datasources/dbfunctions/categorydbrepo.dart';
import '../../data/models/taskmodel.dart';
import '../../../viewmodel/appviewmodel.dart';

import '../widgets/taskdetailwidgets/showtaskdetails.dart';

const List<String> sampleItem = ['Today', 'Tomorrow', 'Custom', 'Clear'];

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
  void initState() {
    BlocProvider.of<TaskBloc>(context).add(LoadTaskEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF012838),
      statusBarIconBrightness: Brightness.light,
    ));
    // return Consumer<AppViewModel>(builder: (context, viewModel, child) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  gradient: LinearGradient(
                    begin: const Alignment(1.392, 4.273),
                    end: const Alignment(-2.084, -18.136),
                    colors: <Color>[
                      primaryclr1,
                      primaryclr2,
                    ],
                    stops: const [0, 1],
                  ),
                ),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //searchbar
                      Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: 40,
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                              border: Border.all(color: primaryclr4),
                              borderRadius: BorderRadius.circular(25)),
                          margin: const EdgeInsets.fromLTRB(10, 20, 10, 15),
                          child: const SearchBarWidget()),

                      //filter
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                        child: PopupMenuButton<String>(
                          icon: Icon(Icons.filter_alt_outlined,
                              color: primaryclr4),
                          initialValue: selectedMenu,
                          // Callback that sets the selected popup menu item.
                          onSelected: (String item) async {
                            setState(() {
                              selectedMenu = item;
                            });
                            if (selectedMenu == sampleItem[2]) {
                              await selectDateRange(context);
                              //viewModel.setDateFilter(startDate, endDate);
                            }

                            //viewModel.setFilterSelection(selectedMenu!);
                            //viewModel.addToFilteredList();
                            BlocProvider.of<TaskBloc>(context).add(
                                SearchFilterTaskEvent(
                                    filterkey: selectedMenu!,
                                    date1: startDate,
                                    date2: endDate));
                            selectedMenu = null;
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: sampleItem[0],
                              child: const Text('Today'),
                            ),
                            PopupMenuItem<String>(
                              value: sampleItem[1],
                              child: const Text('Tomorrow'),
                            ),
                            PopupMenuItem<String>(
                              value: sampleItem[2],
                              child: const Text('Custom Date'),
                            ),
                            PopupMenuItem<String>(
                              value: sampleItem[3],
                              child: const Text('Clear Filter'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  //choicechip
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                    height: 50,
                    child: FutureBuilder(
                        future: CategRepository.getAllData(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<CategoryModel>> snapshot) {
                          if (snapshot.hasData) {
                            //set list to be used for chip

                            //initial chip configuration
                            List<Widget> initialchip = [
                              ChoiceChip(
                                label: const Text('All Tasks'),
                                labelStyle: TextStyle(
                                    color: chosenValue == ''
                                        ? primaryclr3
                                        : primaryclr4),
                                selected: chosenValue == '',
                                shape: StadiumBorder(
                                    side: BorderSide(color: primaryclr4)),
                                backgroundColor: primaryclr1,
                                selectedColor: primaryclr4,
                                elevation: 0,
                                onSelected: (bool selected) async {
                                  //await viewModel.addToTaskList();

                                  //for all task selection
                                  BlocProvider.of<TaskBloc>(context)
                                      .add(LoadTaskEvent());

                                  setState(() {
                                    chosenValue = '';
                                  });
                                },
                              )
                            ];
                            List<Widget> chipList = List<Widget>.generate(
                              snapshot.data!.length,
                              (int index) {
                                return ChoiceChip(
                                  shape: StadiumBorder(
                                      side: BorderSide(color: primaryclr4)),
                                  backgroundColor: primaryclr1,
                                  selectedColor: primaryclr4,
                                  elevation: 0,
                                  padding: const EdgeInsets.all(5),
                                  label: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconList.iconValueList[snapshot
                                          .data![index].category_logo_value],
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        snapshot.data![index].category_name
                                            .toTitleCase(),
                                      )
                                    ],
                                  ),
                                  labelStyle: TextStyle(
                                      color: chosenValue ==
                                              snapshot
                                                  .data![index].category_name
                                          ? primaryclr3
                                          : primaryclr4),
                                  selected: chosenValue ==
                                      snapshot.data![index].category_name,
                                  onSelected: (bool selected) async {
                                    BlocProvider.of<CategoryBloc>(context)
                                        .add(LoadCategoryEvent());
                                    String value = selected
                                        ? snapshot.data![index].category_name
                                        : '';
                                    chosenID =
                                        CategoryFunctionRepo.getCategoryId(
                                            value);
                                    
                                    BlocProvider.of<TaskBloc>(context).add(
                                        SearchFilterTaskEvent(
                                            chosedId: chosenID));

                                    setState(() {
                                      chosenValue = value;
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

            //list display

            chosenValue == ''
                ? const ShowTaskDetail()
                : ShowTaskDetail(chosenId: chosenID),
          ],
        )),
      ),
    );
    //});
  }

  Future<void> selectDateRange(BuildContext ctx) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(const Duration(hours: 24 * 3)),
    );

    final newDateRange = await showDateRangePicker(
      context: ctx,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDateRange: initialDateRange,
      helpText: 'Selected Date Range',
      builder: (context, child) {
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.85,
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(primary: primaryclr2),
              ),
              child: child!,
            ),
          ),
        );
      },
    );

    if (newDateRange == null) {
      setState(() {
        startDate = null;
        endDate = null;
      });
    } else {
      setState(() {
        startDate = newDateRange.start;
        endDate = newDateRange.end;
      });
    }
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure? Do you want to exit App?'),
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold, color: primaryclr3, fontSize: 16),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(
                  "NO",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text("YES",
                    style: TextStyle(
                        color: dangerColor, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        )) ??
        false;
  }
}
