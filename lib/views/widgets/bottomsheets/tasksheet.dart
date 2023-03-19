import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/constants/iconlist.dart';
import 'package:todoapp/dbfunctions/repository.dart';
import 'package:todoapp/viewmodel/appviewmodel.dart';

import '../../../dbfunctions/categorydbrepo.dart';
import '../../../dbfunctions/taskdbrepo.dart';

import '../../../models/categorymodel.dart';
import '../../../models/taskmodel.dart';

class TaskSheetWidget extends StatefulWidget {
  const TaskSheetWidget({super.key});

  @override
  State<TaskSheetWidget> createState() => _TaskSheetWidgetState();
}

class _TaskSheetWidgetState extends State<TaskSheetWidget> {
  int selectedChoiceIndex = 1;
  int defaultChoiceIndex = 0;
  static final _formKey = GlobalKey<FormState>();
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  DateTime? date;
  TimeOfDay? time;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(
      builder: (context, viewModel, child) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            //height: 350,
            margin: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  //top close and done section
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close)),
                    trailing: TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          debugPrint(
                              'selected in onpressed $selectedChoiceIndex');
                          await addTasktoModel(context);

                          viewModel.addTaskList();
                          //viewModel.addCTaskList(selectedChoiceIndex);
                          //debugPrint("hiii"+viewModel.categModelList.toString());

                          Navigator.pop(context);
                        } else {
                          debugPrint('Empty fields found');
                        }
                      },
                      child: const Text(
                        'Done',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),

                  //newtask
                  const Text(
                    'Add New Task',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),

                  //textfieldbar
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter category name';
                      } else {
                        return null;
                      }
                    },
                    controller: _inputController,
                    decoration:
                        const InputDecoration(hintText: 'Enter Task Name'),
                  ),

                  //datepicker

                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 10),
                    child: const Text(
                      'Pick a Date and Time',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),

                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextFormField(
                          readOnly: true,
                          controller: _dateController,
                          onTap: () async {
                            DateTime? pickdate = await showDatePicker(
                                context: context,
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                          primary: Color(0xff00a9a5)),
                                    ),
                                    child: child!,
                                  );
                                },
                                initialDate: date ?? DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(DateTime.now().year + 5));

                            if (pickdate == null) {
                              _dateController.clear();
                            } else {
                              date = pickdate;

                              setState(() {
                                _dateController.text =
                                    DateFormat('EEE, dd/MM/yyyy')
                                        .format(pickdate);
                                //'${pickdate.weekday} ${pickdate.day}/${pickdate.month}/${pickdate.year}';
                              });
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Pick a date';
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(hintText: 'Date'),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextFormField(
                          readOnly: true,
                          controller: _timeController,
                          onTap: () async {
                            TimeOfDay? picktime = await showTimePicker(
                              context: context,
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                        primary: Color(0xff00a9a5)),
                                  ),
                                  child: child!,
                                );
                              },
                              initialTime:
                                  time ?? TimeOfDay(hour: 9, minute: 0),
                            );

                            if (picktime == null) {
                              _timeController.clear();
                            } else {
                              time = picktime;

                              setState(() {
                                _timeController.text = picktime.format(context);
                              });
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Pick a time';
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(hintText: 'Time'),
                        ),
                      ),
                    ],
                  ),

                  //select category
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 10),
                    child: const Text(
                      'Select Category',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),

                  //choice chip for select
                  FutureBuilder(
                      future: CategRepository.getAllData(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<CategoryModel>> snapshot) {
                        if (snapshot.hasData) {
                          //selectedChoiceIndex = snapshot.data![0].cid!;
                          return ListView(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                List.generate(snapshot.data!.length, (index) {
                              return SizedBox(
                                width: 200,
                                child: ChoiceChip(
                                  label: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        IconList.Iconlist[snapshot
                                            .data![index].category_logo_value],
                                        //to add space between icon and taskname
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(snapshot
                                            .data![index].category_name),
                                      ]),
                                  selected: defaultChoiceIndex == index,
                                  selectedColor:
                                      const Color.fromARGB(255, 220, 219, 219),
                                  onSelected: (value) {
                                    selectedChoiceIndex =
                                        snapshot.data![index].cid!;
                                    setState(() {
                                      defaultChoiceIndex =
                                          value ? index : defaultChoiceIndex;

                                      debugPrint(
                                          "selected $selectedChoiceIndex default $defaultChoiceIndex");
                                    });
                                  },
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  padding: const EdgeInsets.all(8),
                                ),
                              );
                            }),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<TaskModel> addTasktoModel(BuildContext ctx) async {
    final _taskname = _inputController.text.trim();
    final _date = _dateController.text.trim();
    final _time = _timeController.text.trim();
    final cidOut = await CategRepository.fetchFirstCid();
    final _logoindex =
        selectedChoiceIndex == 1 ? cidOut[0]['cid'] : selectedChoiceIndex;

    final _currUserId = Repository.currentUserID;
    debugPrint("I am userid " + _currUserId.toString());

    final _taskObject = TaskModel(
        task_name: _taskname,
        isCompleted: 0,
        category_id: _logoindex,
        user_id: _currUserId,
        task_date_time: DateTime(
            date!.year, date!.month, date!.day, time!.hour, time!.minute));

    /* print("$_name $_email before calling savedata"); */

    bool out = await TaskRepository.saveData(_taskObject);

    if (out != true) {
      var snackBar = const SnackBar(
        content: Text(
          'Oh Snap! Looks like task already exist!',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        padding: EdgeInsets.all(20),
        duration: Duration(seconds: 4),
      );
      ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
    } else {
      var snackBar = const SnackBar(
        content: Text(
          'Success',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        padding: EdgeInsets.all(20),
        duration: Duration(seconds: 4),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    debugPrint(out.toString());

    return _taskObject;
  }
}
