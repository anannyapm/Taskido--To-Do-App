import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/views/screens/login.dart';
import 'package:todoapp/views/screens/signup.dart';
import 'package:todoapp/views/widgets/gradientbox.dart';

class OnboardingHome extends StatelessWidget {
  const OnboardingHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: AssetImage('assets/images/screentwobg.png'),
                  scale: 0.9,
                  fit: BoxFit.contain)),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            //set background
            body: Column(
              children: [
                Expanded(
                  flex: 9,
                  child: Container(
                    height: (MediaQuery.of(context).size.height) * 0.7,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Stack(
                    children: [
                      Positioned(
                        child: Align(
                          child: SizedBox(
                            width: 280,
                            height: 100,
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5,
                                  color: Color(0xff011638),
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        'The secret of getting ahead is getting ',
                                  ),
                                  TextSpan(
                                    text: 'STARTED!',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      height: 1.5,
                                      color: Color(0xff011638),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 18,
                        top: -25,
                        width: 49,
                        height: 80,
                        child: SizedBox(
                          child: Text(
                            '“',
                            style: TextStyle(
                              fontFamily: GoogleFonts.poly().fontFamily,
                              fontSize: 130,
                              fontWeight: FontWeight.w500,
                              color: const Color(0x11000000),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Align(
                      child: GradientBox(
                    colorStart: const Color.fromARGB(255, 255, 255, 255),
                    colorEnd: const Color.fromARGB(255, 4, 209, 206),
                    gradFunction: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const ScreenSignUp())),
                    textVal: "Sign Up",
                    textColor: const Color(0xff011638),
                  )),
                ),
                Expanded(
                  flex: 1,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const ScreenLogin())),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          height: 1.5,
                          color: Color(0xff000000),
                        ),
                        children: [
                          TextSpan(
                            text: 'Already have an account?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              height: 1.5,
                              color: Color(0xbf011638),
                            ),
                          ),
                          TextSpan(
                            text: ' ',
                          ),
                          TextSpan(
                            text: 'Log In',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              height: 1.5,
                              color: Color(0xff011638),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
