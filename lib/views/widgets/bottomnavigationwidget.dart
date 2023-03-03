import 'package:flutter/material.dart';

import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:todoapp/views/screens/home.dart';

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectedIndexNotifier,
      builder: (BuildContext ctx, int updatedIndex, Widget? _) {
        return BottomNavigationBar(
         
          
            currentIndex: updatedIndex,
            onTap: (newIndex) {
              ScreenHome.selectedIndexNotifier.value = newIndex;
            },
            backgroundColor: const Color.fromARGB(252, 246, 246, 246),
            selectedItemColor: const Color(0xFF268585),
            unselectedItemColor: const Color(0xFF011638),
            // ignore: prefer_const_literals_to_create_immutables
            items: [
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesome5.tasks,
                  ),
                  label: 'Tasks'),
            ]);
      },
    );
  }
}
