import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';


class TaskSheetWidget extends StatefulWidget {
  const TaskSheetWidget({super.key});

  @override
  State<TaskSheetWidget> createState() => _TaskSheetWidgetState();
}

class _TaskSheetWidgetState extends State<TaskSheetWidget> {
   final List<Icon> _choicesList = [
    const Icon(FontAwesome.heart,color: Color(0xffF96900),size: 20,),
    const Icon(FontAwesome.suitcase,color:Color(0xff66635B),size: 20,),
    const Icon(FontAwesome.flight,color: Colors.blue,size: 20,),
    const Icon(FontAwesome.money,color: Colors.green,size: 20,),
    const Icon(Icons.movie,color: Color(0xff00A9A5),size: 20,),
    const Icon(Icons.sports_gymnastics,color: Color.fromARGB(255, 28, 8, 0),size: 20,),

  ];
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
            'Add New Category',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),

          //textfieldbar
          const TextField(
            decoration: InputDecoration(hintText: 'Enter Category Name'),
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
            children: List.generate(_choicesList.length, (index) {
              return ChoiceChip(
                label: _choicesList[index],
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
    );
  }
}
