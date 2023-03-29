import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/constants/colorconstants.dart';
import 'package:todoapp/viewmodel/appviewmodel.dart';
import 'package:todoapp/views/widgets/snackbar.dart';
import '../../../dbfunctions/taskdbrepo.dart';
import '../../../models/taskmodel.dart';

class UpdateTaskSheetWidget extends StatefulWidget {
  final TaskModel taskdata;

  const UpdateTaskSheetWidget({super.key, required this.taskdata});

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
    
    super.initState();
    _inputController = TextEditingController(text: widget.taskdata.task_name);
    _dateController = TextEditingController(
        text: DateFormat('EEE, dd/MM/yyyy')
            .format(widget.taskdata.task_date_time));
    _timeController = TextEditingController(
        text: DateFormat('hh:mm aaa').format(widget.taskdata.task_date_time));
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
                          if (widget.taskdata.task_name !=
                                  _inputController.text.trim() ||
                              date != null ||
                              time != null) {
                            await updateTasktoModel(context);
                            viewModel.addToTaskList();
                          } else {
                            snackBarWidget(
                                context, 'No Edits Made', Colors.amber);
                          }

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

                  const Text(
                    'Update Task',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),

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
                                      colorScheme:  ColorScheme.light(
                                          primary: primaryclr2),
                                    ),
                                    child: child!,
                                  );
                                },
                                initialDate: date ?? DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(DateTime.now().year + 5));

                            if (pickdate == null) {
                              //_dateController.clear();
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
                                    colorScheme:
                                        ColorScheme.light(primary: primaryclr2),
                                  ),
                                  child: child!,
                                );
                              },
                              initialTime: time ??
                                  TimeOfDay(
                                      hour: widget.taskdata.task_date_time.hour,
                                      minute: widget
                                          .taskdata.task_date_time.minute),
                            );

                            if (picktime == null) {
                              //_timeController.clear();
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

  Future<void> updateTasktoModel(BuildContext ctx) async {
    final taskname = _inputController.text.trim();

    final DateTime? taskDateTime;
    TaskModel taskitem = widget.taskdata;
    if (date == null && time == null) {
      taskDateTime = taskitem.task_date_time;
    } else if (date == null) {
      taskDateTime = DateTime(
          taskitem.task_date_time.year,
          taskitem.task_date_time.month,
          taskitem.task_date_time.day,
          time!.hour,
          time!.minute);
    } else {
      taskDateTime = DateTime(date!.year, date!.month, date!.day,
          taskitem.task_date_time.hour, taskitem.task_date_time.minute);
    }

    final out = await TaskRepository.updateData(taskitem.tid!,
        taskitem.category_id, taskitem.user_id, taskname, taskDateTime);

    if (out.isNotEmpty) {
      snackBarWidget(ctx, 'Oh Snap!Something Went Wrong!', dangerColor);
    } else {
      snackBarWidget(ctx, 'Update Success!', successColor);
    }

    debugPrint(out.toString());
  }
}
