import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todoapp/features/presentation/pages/onboardinghome.dart';
import 'package:todoapp/features/presentation/widgets/gradientbox.dart';

import '../constants/colorconstants.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: primaryclr4,
      statusBarIconBrightness: Brightness.dark,
    ));
    return SafeArea(
      //set background
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: primaryclr4,
        ),

        //Scaffold area
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                flex: 10,
                child: Align(
                  child: Container(
                    transform: Matrix4.rotationZ(6.9),
                    transformAlignment: Alignment.center,
                    height: (MediaQuery.of(context).size.height) * 0.4,
                    child: Image.asset(
                      'assets/images/clock.png',
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 20),
                       
                        child: Image.asset(
                          'assets/images/full_logo_light.png',height: 65,
                        )),
                    Text('GET YOUR TASKS DONE!',
                        style: TextStyle(
                            letterSpacing: 3,
                            color: pClr3Shade2,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                    child: GradientBox(
                  colorStart: primaryclr1,
                  colorEnd: primaryclr2,
                  gradFunction: () => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const OnboardingHome()),
                      (route) => false),
                  textVal: "Let's Start",
                  textColor: primaryclr4,
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
