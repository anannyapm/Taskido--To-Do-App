import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/constants/iconlist.dart';
import 'package:todoapp/dbfunctions/repository.dart';
import 'package:todoapp/models/appviewmodel.dart';

import '../../../dbfunctions/categorydbrepo.dart';
import '../../../dbfunctions/taskdbrepo.dart';
import '../../../models/categoryclass.dart';
import '../../../models/categorymodel.dart';
import '../../../models/oldtaskmodel.dart';
import '../../../models/taskmodel.dart';

class TaskSheetWidget extends StatefulWidget {
  const TaskSheetWidget({super.key});

  @override
  State<TaskSheetWidget> createState() => _TaskSheetWidgetState();
}

class _TaskSheetWidgetState extends State<TaskSheetWidget> {
  int defaultChoiceIndex = 0;
  static final _formKey = GlobalKey<FormState>();
  final TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(
      builder: (context, viewModel, child) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: 350,
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
                          await addTasktoModel(defaultChoiceIndex + 1, context);

                          viewModel.addTaskList();
                          viewModel.addCTaskList(defaultChoiceIndex);
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

                  //select title
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

  Future<TaskModel> addTasktoModel(int choiceIndex, BuildContext ctx) async {
    final _taskname = _inputController.text.trim();
    final _logoindex = choiceIndex;

    final _currUserId = Repository.currentUserID;
    debugPrint("I am userid " + _currUserId.toString());

    final _taskObject = TaskModel(
        task_name: _taskname,
        isCompleted: 0,
        category_id: choiceIndex,
        user_id: _currUserId);

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
