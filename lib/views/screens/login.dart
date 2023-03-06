import 'package:flutter/material.dart';
import 'package:todoapp/views/screens/home.dart';
import 'package:todoapp/views/screens/signup.dart';
import 'package:todoapp/views/widgets/gradientbox.dart';

import '../widgets/loginwidgets/bottombarwidget.dart';
import '../widgets/loginwidgets/headingmessage.dart';
import '../widgets/loginwidgets/textfieldwidget.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              alignment: Alignment.topRight,
              image: AssetImage('assets/images/Vector2.png'),
              scale: 1.5,
            )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          //resizeToAvoidBottomInset:false,
          body: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color: const Color.fromARGB(107, 51, 51, 51))),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(
                            /* MaterialPageRoute(
                            builder: (ctx) => const OnboardingHome()) */
                            );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Expanded(
                    flex: 6,
                    child: SingleChildScrollView(
                      child: Container(
                        height: (MediaQuery.of(context).size.height) * 0.75,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const HeadingMessage(
                              heading: "Welcome Back!\n",
                              subheading:
                                  "Woo Hoo!\nIt's time to check back in",
                            ),

                            const SizedBox(
                              height: 50,
                            ),

                            Form(
                              key: _formKey,

                              //child: Expanded(
                              child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                //mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const TextFieldWidget(
                                      hint: "Enter Email Address",
                                      label: "Email Address"),
                                  /* const SizedBox(
                                    height: 20,
                                  ), */
                                  Align(
                                    child: GradientBox(
                                      colorStart: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      colorEnd: const Color.fromARGB(
                                          255, 4, 209, 206),
                                      gradFunction: () {
                                        if (_formKey.currentState!.validate()) {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ScreenHome()));
                                        } else {
                                          //print('Empty field found');
                                        }
                                      },
                                      textVal: "Log In",
                                      textColor: const Color(0xff011638),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            //),

                            Expanded(
                              flex: 1,
                              child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: BottomTextButton(
                                      linkText: 'Sign Up',
                                      function: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  const ScreenSignUp())))),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}