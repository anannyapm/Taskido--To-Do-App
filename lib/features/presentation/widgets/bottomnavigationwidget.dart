import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todoapp/features/presentation/constants/colorconstants.dart';

import '../../../viewmodel/appviewmodel.dart';


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
            backgroundColor: const Color(0xFBF6F6F6),
            selectedItemColor: const Color(0xFF268585),
            unselectedItemColor:  primaryclr1,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.task,
                  ),
                  label: 'Tasks'),
            ]);
      },
    );
  }
}
