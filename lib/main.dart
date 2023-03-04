

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/appviewmodel.dart';
import 'package:todoapp/views/screens/splashscreen.dart';

void main() {
  runApp(ChangeNotifierProvider(create:(context)=>AppViewModel(),child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.poppins().fontFamily,
        
      ),
      home: const ScreenSplash(),
    );
  }
}

