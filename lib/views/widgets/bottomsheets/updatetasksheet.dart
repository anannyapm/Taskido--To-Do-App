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

class UpdateTaskSheetWidget extends StatefulWidget {
  final String taskName;
  final DateTime date;


  const UpdateTaskSheetWidget({super.key,required this.taskName,required this.date});

  @override
  State<UpdateTaskSheetWidget> createState() => _UpdateTaskSheetWidgetState();
}

class _UpdateTaskSheetWidgetState extends State<UpdateTaskSheetWidget> {
  
  final _formKey = GlobalKey<FormState>();
  TextEditingController _inputController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  DateTime? date;
  TimeOfDay? time;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     _inputController = TextEditingController(text: widget.taskName);
  _dateController = TextEditingController(text: DateFormat('EEE, dd/MM/yyyy')
                                        .format(widget.date));
  _timeController = TextEditingController(text: DateFormat('hh:mm aaa').format(widget.date));
  }

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
                          //change it to update
                          /* await addTasktoModel(context);

                          viewModel.addToTaskList(); */

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
                    'Update Task',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),

                  //textfieldbar
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a task name';
                      } else {
                        return null;
                      }
                    },
                    controller: _inputController,
                    decoration:
                        const InputDecoration(hintText: 'Enter New Task Name'),
                  ),

                  //datepicker

                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 10),
                    child: const Text(
                      'Add New Date and Time',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),

                  Row(
                    children: [
                      SizedBox(
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
                                      colorScheme: const ColorScheme.light(
                                          primary: Color(0xff00a9a5)),
                                    ),
                                    child: child!,
                                  );
                                },
                                initialDate: date ?? DateTime.now(),
                                firstDate: widget.date,
                                lastDate: DateTime(DateTime.now().year + 5));

                            if (pickdate == null) {
                              _dateController.clear();
                            } else {
                              date = pickdate;

                              setState(() {
                                _dateController.text =
                                    DateFormat('EEE, dd/MM/yyyy')
                                        .format(pickdate);
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
                      SizedBox(
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
                                    colorScheme: const ColorScheme.light(
                                        primary: Color(0xff00a9a5)),
                                  ),
                                  child: child!,
                                );
                              },
                              initialTime:
                                  time ??  TimeOfDay(hour: widget.date.hour, minute: widget.date.minute),
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

                  

                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /* Future<TaskModel> updateTasktoModel(BuildContext ctx) async {
    final _taskname = _inputController.text.trim();
    final _date = _dateController.text.trim();
    final _time = _timeController.text.trim();
    final cidOut = await CategRepository.fetchFirstCid();
    
    final _currUserId = Repository.currentUserID;

    final DateTime taskDateTime=DateTime(date!.year, date!.month, date!.day, time!.hour, time!.minute);

    bool out = await TaskRepository.updateData(widget., catid, userid, tname, datetime);

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

    //return _taskObject;
  } */
}
