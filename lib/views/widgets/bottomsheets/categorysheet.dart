import 'package:flutter/material.dart';

import '../../../models/categoryclass.dart';

class CategorySheetWidget extends StatefulWidget {
  const CategorySheetWidget({super.key});

  @override
  State<CategorySheetWidget> createState() => _CategorySheetWidgetState();
}

class _CategorySheetWidgetState extends State<CategorySheetWidget> {
  /*  List<Icon> _choicesList = [
    Icon(FontAwesome.heart,color: Color(0xffF96900),size: 20,),
    Icon(FontAwesome.suitcase,color:Color(0xff66635B),size: 20,),
    Icon(FontAwesome.flight,color: Colors.blue,size: 20,),
    Icon(FontAwesome.money,color: Colors.green,size: 20,),
    Icon(Icons.movie,color: Color(0xff00A9A5),size: 20,),
    Icon(Icons.sports_gymnastics,color: Color.fromARGB(255, 28, 8, 0),size: 20,),

  ]; */
  int defaultChoiceIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
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
                Navigator.pop(context);
              },
              child: const Text(
                'Done',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),

          //newtask
          const Text(
            'Add New Task',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),

          //textfieldbar
          const TextField(
            decoration: InputDecoration(hintText: 'Enter Task Name'),
          ),

          //select title
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            child: const Text(
              'Select Category',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),

          //choice chip for select
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(categoryList.length, (index) {
              return SizedBox(
                width: 200,
                child: ChoiceChip(
                  label: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        categoryList[index].taskIcon,
                        //to add space between icon and taskname
                        const SizedBox(
                          width: 20,
                        ),
                        Text(categoryList[index].taskName),
                      ]),
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
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
