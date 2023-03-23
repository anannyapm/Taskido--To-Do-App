import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todoapp/dbfunctions/categorydbrepo.dart';
import 'package:todoapp/dbfunctions/repository.dart';
import 'package:todoapp/viewmodel/appviewmodel.dart';
import 'package:todoapp/models/categorymodel.dart';

import '../../../constants/iconlist.dart';

class CategorySheetWidget extends StatefulWidget {
  const CategorySheetWidget({super.key});

  @override
  State<CategorySheetWidget> createState() => _CategorySheetWidgetState();
}

class _CategorySheetWidgetState extends State<CategorySheetWidget> {
  int defaultChoiceIndex = 0;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 300,
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
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close)),
                  trailing: TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await addCategorytoModel(defaultChoiceIndex, context);

                        viewModel.addToCategList();

                        Navigator.pop(context);
                      } else {
                        debugPrint('Empty fields found');
                      }
                    },
                    child: const Text(
                      'Done',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),

                //newtask
                const Text(
                  'Add New Category',
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
                      const InputDecoration(hintText: 'Enter Category Name'),
                ),

                //select title
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 10),
                  child: const Text(
                    'Select an Icon',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),

                //choice chip for select
                Wrap(

                  children:
                      List.generate(IconList.iconValueList.length, (index) {
                    return ChoiceChip(
                      label: IconList.iconValueList[index],
                      selected: defaultChoiceIndex == index,
                      selectedColor: const Color.fromARGB(255, 220, 219, 219),
                      onSelected: (value) {
                        setState(() {
                          defaultChoiceIndex =
                              value ? index : defaultChoiceIndex;
                        });
                      },
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      padding: const EdgeInsets.all(8),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<CategoryModel> addCategorytoModel(
      int choiceIndex, BuildContext ctx) async {
    final _name = _inputController.text.trim();
    final _logoindex = choiceIndex;

    final _categoryObject = CategoryModel(
        category_name: _name,
        category_logo_value: _logoindex,
        isDeleted: 0,
        user_id: Repository.currentUserID);

    bool out = await CategRepository.saveData(_categoryObject);

    if (out != true) {
      var snackBar = const SnackBar(
        content: Text(
          'Oh Snap! Catrgory already exist.',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        padding: EdgeInsets.all(20),
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
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    debugPrint(out.toString());

    return _categoryObject;
  }
}
