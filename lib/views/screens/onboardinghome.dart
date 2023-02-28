import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                  scale: 0.9)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            //set background
            body: Column(
              children: [
                const SizedBox(
                  height: 480,
                ),
                Stack(
                  children: [
                    Positioned(
                      child: Align(
                        child: SizedBox(
                          width: 300,
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
                      left: 20,
                      top: -30,
                      width: 49,
                      height: 80,
                      child: SizedBox(
                        child: Text(
                          '“',
                          style: TextStyle(
                            fontFamily: GoogleFonts.poly().fontFamily,
                            fontSize: 130,
                            fontWeight: FontWeight.w500,
                            color: const Color(0x1e000000),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  child: Container(
                    width: 286,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.5),
                      gradient: const LinearGradient(
                        begin: Alignment(-2.084, -18.136),
                        end: Alignment(1.392, 4.273),
                        colors: <Color>[
                          Color.fromARGB(255, 255, 255, 255),
                          Color.fromARGB(255, 4, 209, 206)
                        ],
                        stops: <double>[0, 1],
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const OnboardingHome()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        //shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.5)),
                      ),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 22,
                            color: Color(0xff011638)),
                      ),
                    ),
                  ),
                ),
                Container(
                  // alreadyhaveanaccountloginSbh (8:45)
                  margin: const EdgeInsets.fromLTRB(1, 0, 0, 0),
                  child: TextButton(
                    onPressed: () {},
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
