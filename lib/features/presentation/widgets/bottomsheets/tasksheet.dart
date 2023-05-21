import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/features/presentation/bloc/taskbloc/task_bloc.dart';
import 'package:todoapp/features/presentation/bloc/taskbloc/task_event.dart';
import 'package:todoapp/features/presentation/bloc/taskbloc/task_state.dart';
import 'package:todoapp/features/presentation/constants/iconlist.dart';

import 'package:todoapp/viewmodel/appviewmodel.dart';
import 'package:todoapp/features/presentation/widgets/snackbar.dart';

import '../../constants/colorconstants.dart';
import '../../../data/datasources/dbfunctions/categorydbrepo.dart';

import '../../../data/models/categorymodel.dart';

class TaskSheetWidget extends StatefulWidget {
  const TaskSheetWidget({super.key});

  @override
  State<TaskSheetWidget> createState() => _TaskSheetWidgetState();
}

class _TaskSheetWidgetState extends State<TaskSheetWidget> {
  int selectedChoiceIndex = 1;
  int defaultChoiceIndex = 0;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  DateTime? date;
  TimeOfDay? time;

  @override
  Widget build(BuildContext context) {

        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            //height: 350,
            margin: const EdgeInsets.all(10),
            child: BlocListener<TaskBloc, TaskState>(
              listener: (context, state) {
                if (state is TaskCreateState) {
                  snackBarWidget(context, 'Task Added', successColor);
                  Navigator.pop(context);
                } else if (state is TaskErrorState) {
                  snackBarWidget(context, state.errormsg, dangerColor);
                  Navigator.pop(context);
                }
              },
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
                            BlocProvider.of<TaskBloc>(context).add(AddTaskEvent(
                                categId: selectedChoiceIndex,
                                taskname: _inputController.text,
                                date: date!,
                                time: time!));

                            
                            /* await addTasktoModel(context);

                            viewModel.addToTaskList();

                            Navigator.pop(context); */
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),

                    //textfieldbar
                    TextFormField(
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().isEmpty) {
                          return 'Please enter task name';
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
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
                                        colorScheme: ColorScheme.light(
                                            primary: primaryclr2),
                                      ),
                                      child: child!,
                                    );
                                  },
                                  initialDate: date ?? DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate:
                                      DateTime(DateTime.now().year + 500));

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
                                      colorScheme: ColorScheme.light(
                                          primary: primaryclr2),
                                    ),
                                    child: child!,
                                  );
                                },
                                initialTime: time ?? TimeOfDay.now(),
                              );

                              if (picktime == null) {
                                _timeController.clear();
                              } else {
                                time = picktime;

                                setState(() {
                                  _timeController.text =
                                      picktime.format(context);
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),

                    //choice chip for select
                    FutureBuilder(
                        future: CategRepository.getAllData(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<CategoryModel>> snapshot) {
                          if (snapshot.hasData) {
                            return ListView(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              children:
                                  List.generate(snapshot.data!.length, (index) {
                                return SizedBox(
                                  width: 200,
                                  child: ChoiceChip(
                                    label: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          IconList.iconValueList[snapshot
                                              .data![index]
                                              .category_logo_value],
                                          //to add space between icon and taskname
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Text(snapshot
                                              .data![index].category_name),
                                        ]),
                                    selected: defaultChoiceIndex == index,
                                    selectedColor: pClr4Shade1,
                                    onSelected: (value) {
                                      selectedChoiceIndex =
                                          snapshot.data![index].cid!;
                                      setState(() {
                                        defaultChoiceIndex =
                                            value ? index : defaultChoiceIndex;
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
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
        );
      
  }

  /*  Future<TaskModel> addTasktoModel(BuildContext ctx) async {
    final taskname =
        _inputController.text.trim().replaceAll(RegExp(r"\s+"), " ");
    final cidOut = await CategRepository.fetchFirstCid();
    final logoindex =
        selectedChoiceIndex == 1 ? cidOut[0]['cid'] : selectedChoiceIndex;

    final currUserId = Repository.currentUserID;

    final taskObject = TaskModel(
        task_name: taskname,
        isCompleted: 0,
        category_id: logoindex,
        user_id: currUserId,
        task_date_time: DateTime(
            date!.year, date!.month, date!.day, time!.hour, time!.minute));

    bool out = await TaskRepository.saveData(taskObject);

    if (out != true) {
      snackBarWidget(
          ctx, 'Oh Snap! Looks like task already exist!', dangerColor);
    } else {
      snackBarWidget(ctx, 'Task Added', successColor);
    }

    return taskObject;
  } */
}
