// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:todoapp/features/presentation/bloc/categorybloc/category_bloc.dart';
import 'package:todoapp/features/presentation/bloc/pagenavbloc/pagenav_bloc.dart';
import 'package:todoapp/features/presentation/bloc/photobloc/photo_bloc.dart';
import 'package:todoapp/features/presentation/bloc/taskbloc/task_bloc.dart';
import 'package:todoapp/features/presentation/bloc/userbloc/user_bloc.dart';

import 'package:todoapp/features/presentation/pages/initialsplashscreen.dart';

//converting to bloc

const SAVE_KEY_NAME = 'UserLoggedIn'; //value of shared prefrence stored here
const SAVE_KEY_PROFILE =
    'UserProfileImage'; //value of shared prefrence stored here

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => TaskBloc()),
        BlocProvider(create: (context) => CategoryBloc()),
        BlocProvider(create: (context) => PageNavBloc()),
        BlocProvider(create: (context) => PhotoBloc()),
      ],
      child: MaterialApp(
        title: 'Taskido App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
        home: const ScreenInitialSplash(),
      ),
    );
  }
}
