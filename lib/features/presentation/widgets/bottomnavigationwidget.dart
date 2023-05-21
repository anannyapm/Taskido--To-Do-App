import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todoapp/features/presentation/bloc/pagenavbloc/pagenav_bloc.dart';
import 'package:todoapp/features/presentation/bloc/pagenavbloc/pagenav_event.dart';
import 'package:todoapp/features/presentation/bloc/pagenavbloc/pagenav_state.dart';
import 'package:todoapp/features/presentation/constants/colorconstants.dart';

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageNavBloc, PageNavState>(
      builder: (context, state) {
   
          return BottomNavigationBar(
              currentIndex: state.selectedIndexNotifier,
              onTap: (newIndex) {
                BlocProvider.of<PageNavBloc>(context)
                    .add(PageNavActivateEvent(newIndex: newIndex));
              },
              backgroundColor: const Color(0xFBF6F6F6),
              selectedItemColor: const Color(0xFF268585),
              unselectedItemColor: primaryclr1,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.task_alt,
                    ),
                    label: 'Tasks'),
              ]);
        } 
      
    );
  }
}
