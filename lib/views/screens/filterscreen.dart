/* import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:provider/provider.dart';

import '../../constants/iconlist.dart';
import '../../dbfunctions/categorydbrepo.dart';
import '../../models/categorymodel.dart';
import '../../viewmodel/appviewmodel.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  DateTime? startDate;
  DateTime? endDate;
  String chosenValue = '';
  int _selectedcatid = 0;
  String _selecteddateoption = "";
  List option = ['Category', 'Date'];
  String _selectedOption = 'Category';

  int chosenID = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return AlertDialog(
        title: const Text('Filter'),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: Column(
              //mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: double.maxFinite,
                        /* decoration: BoxDecoration(
                            border: BorderDirectional(
                                end: BorderSide(
                                    color: Color.fromARGB(29, 0, 0, 0)))), */
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),

                          //mainAxisAlignment: MainAxisAlignment.center,
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          itemCount: option.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              contentPadding: EdgeInsets.all(0),
                              textColor: _selectedOption == option[index]
                                  ? Color.fromARGB(255, 0, 129, 86)
                                  : null,
                              title: Text(option[index]),
                              onTap: () {
                                setState(() {
                                  _selectedOption = option[index];
                                });
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              thickness: 1,
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            border: BorderDirectional(
                                start: BorderSide(color: Colors.black))),
                        width: double.maxFinite,
                        //margin: EdgeInsets.only(left: 10),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Select an option'),
                            _selectedOption == 'Category'
                                ? Container(
                                    height: 360,
                                    child: FutureBuilder(
                                        future: CategRepository.getAllData(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<List<CategoryModel>>
                                                snapshot) {
                                          if (snapshot.hasData) {
                                            return ListView.separated(
                                                shrinkWrap: true,
                                                physics:
                                                    ClampingScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  return Card(
                                                    margin: EdgeInsets.zero,
                                                    elevation: 0,
                                                    child: ListTile(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: 10,
                                                              bottom: 0),
                                                      tileColor:
                                                          _selectedcatid ==
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .cid
                                                              ? Color.fromARGB(
                                                                  11, 0, 0, 0)
                                                              : null,
                                                      onTap: () {
                                                        setState(() {
                                                          _selectedcatid =
                                                              snapshot
                                                                  .data![index]
                                                                  .cid!;
                                                        });
                                                      },
                                                      title: Text(snapshot
                                                          .data![index]
                                                          .category_name),
                                                      leading: IconList
                                                              .Iconlist[
                                                          snapshot.data![index]
                                                              .category_logo_value],
                                                    ),
                                                  );
                                                },
                                                separatorBuilder:
                                                    (context, index) {
                                                  return Divider(
                                                    thickness: 1,
                                                  );
                                                },
                                                itemCount:
                                                    snapshot.data!.length);
                                          } else {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }
                                        }),
                                  )
                                //datearea

                                : Container(
                                    height: 360,
                                    child: ListView(
                                      children: [
                                        ListTile(
                                          tileColor:
                                              _selecteddateoption == 'Today'
                                                  ? Color.fromARGB(11, 0, 0, 0)
                                                  : null,
                                          title: Text('Today'),
                                          onTap: () {
                                            setState(() {
                                              _selecteddateoption = 'Today';
                                            });
                                          },
                                        ),
                                        ListTile(
                                          tileColor:
                                              _selecteddateoption == 'Tomorrow'
                                                  ? Color.fromARGB(11, 0, 0, 0)
                                                  : null,
                                          title: Text('Tomorrow'),
                                          onTap: () {
                                            setState(() {
                                              _selecteddateoption = 'Tomorrow';
                                            });
                                          },
                                        ),
                                        ListTile(
                                          tileColor: _selecteddateoption ==
                                                  'Select a Range'
                                              ? Color.fromARGB(11, 0, 0, 0)
                                              : null,
                                          title: Text('Select a Range'),
                                          onTap: () {
                                            setState(() {
                                              _selecteddateoption =
                                                  'Select a Range';
                                              _selectDateRange();
                                              endDate != null
                                                  ? Text(endDate!
                                                      .toIso8601String())
                                                  : debugPrint('0');
                                            });
                                          },
                                        ),
                                        endDate != null
                                            ? Text('hi')
                                            : Text('bi'),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    });
  }

  void _selectDateRange() async {
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
 */