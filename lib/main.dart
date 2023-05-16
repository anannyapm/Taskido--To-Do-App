import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/viewmodel/appviewmodel.dart';
import 'package:todoapp/views/screens/initialsplashscreen.dart';


//converting to bloc

const SAVE_KEY_NAME = 'UserLoggedIn'; //value of shared prefrence stored here 
const SAVE_KEY_PROFILE = 'UserProfileImage'; //value of shared prefrence stored here 

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => AppViewModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
   
      title: 'Taskido App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: const ScreenInitialSplash(),
    );
  }
}

