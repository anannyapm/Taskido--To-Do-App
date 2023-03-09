import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/dbfunctions/categorydbrepo.dart';
import 'package:todoapp/models/appviewmodel.dart';
import 'package:todoapp/models/categorymodel.dart';
import 'package:todoapp/views/widgets/popupdialogue.dart';

import '../../../constants/iconlist.dart';
import '../../../constants/keys.dart';

class CategorySheetWidget extends StatefulWidget {
  const CategorySheetWidget({super.key});

  @override
  State<CategorySheetWidget> createState() => _CategorySheetWidgetState();
}

class _CategorySheetWidgetState extends State<CategorySheetWidget> {
  /* final List<Icon> _choicesList = [
    const Icon(
      FontAwesome.heart,
      color: Color(0xffF96900),
      size: 20,
    ),
    const Icon(
      FontAwesome.suitcase,
      color: Color(0xff66635B),
      size: 20,
    ),
    const Icon(
      FontAwesome.flight,
      color: Colors.blue,
      size: 20,
    ),
    const Icon(
      FontAwesome.money,
      color: Colors.green,
      size: 20,
    ),
    const Icon(
      Icons.movie,
      color: Color(0xff00A9A5),
      size: 20,
    ),
    const Icon(
      Icons.sports_gymnastics,
      color: Color(0xFF1C0800),
      size: 20,
    ),
  ]; */
  int defaultChoiceIndex = 0;

  static final _formKey = GlobalKey<FormState>();
  final TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, viewModel, child) {
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
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close)),
                  trailing: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        addCategorytoModel(defaultChoiceIndex, context);
                        _inputController.text = '';
                  
                        /* var snackBar = const SnackBar(
                          content: Text(
                            'Success',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.all(20),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar); */
                      } else {
                        debugPrint('Empty fields found');
                      }
                    },
                    child: const Text(
                      'Done',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                    if (value == null ||value.isEmpty) {
                      return 'Please enter cetegory name';
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
                Row(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(IconList.Iconlist.length, (index) {
                    return ChoiceChip(
                      label: IconList.Iconlist[index],
                      selected: defaultChoiceIndex == index,
                      selectedColor: const Color.fromARGB(255, 220, 219, 219),
                      onSelected: (value) {
                        setState(() {
                          defaultChoiceIndex = value ? index : defaultChoiceIndex;
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

  Future<void> addCategorytoModel(int choiceIndex, BuildContext ctx) async {
    final _name = _inputController.text.trim();
    final _logoindex = choiceIndex;

    final _categoryObject = CategoryModel(_name, choiceIndex, 0);

    /* print("$_name $_email before calling savedata"); */

    dynamic out = await CategRepository.saveData(_categoryObject);
    if (out != true) {
      var snackBar = const SnackBar(
        content: Text(
          'Oh Snap! Something went wrong.',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        padding: EdgeInsets.all(20),
      );
      ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
    }
    debugPrint(out.toString());
  }
}
