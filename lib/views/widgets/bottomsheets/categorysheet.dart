import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todoapp/dbfunctions/categorydbrepo.dart';
import 'package:todoapp/dbfunctions/repository.dart';
import 'package:todoapp/viewmodel/appviewmodel.dart';
import 'package:todoapp/models/categorymodel.dart';
import 'package:todoapp/views/widgets/snackbar.dart';

import '../../../constants/colorconstants.dart';
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
                      selectedColor: pClr4Shade1,
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
    final name = _inputController.text.trim();
    final logoindex = choiceIndex;

    final categoryObject = CategoryModel(
        category_name: name,
        category_logo_value: logoindex,
        isDeleted: 0,
        user_id: Repository.currentUserID);

    bool out = await CategRepository.saveData(categoryObject);

    if (out != true) {
      snackBarWidget(ctx, 'Oh Snap! Catrgory already exist', dangerColor);
     
    } else {
      snackBarWidget(ctx, 'Category Added Successfully', successColor);

    }


    return categoryObject;
  }
}
