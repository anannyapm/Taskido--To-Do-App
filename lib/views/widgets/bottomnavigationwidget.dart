import 'package:flutter/material.dart';

import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/appviewmodel.dart';

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(
      builder: (context, viewModel, child) {
        return BottomNavigationBar(
            currentIndex: viewModel.selectedIndexNotifier,
            onTap: (newIndex) {
              viewModel.notifyOnIndexChange(newIndex);
            },
            backgroundColor: const Color.fromARGB(252, 246, 246, 246),
            selectedItemColor: const Color(0xFF268585),
            unselectedItemColor: const Color(0xFF011638),
            items: const [
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
