import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
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
            backgroundColor: Colors.white,
            selectedItemColor: Color(0xFF268585),
            unselectedItemColor: Color(0xFF011638),
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesome5.tasks,
                  ),
                  label: 'Tasks'),
            ]);
      },
    );
  }
}
