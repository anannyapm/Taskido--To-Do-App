import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:todoapp/dbfunctions/repository.dart';
import 'package:todoapp/viewmodel/appviewmodel.dart';
import 'package:todoapp/views/screens/home.dart';
import 'package:todoapp/views/screens/signup.dart';
import 'package:todoapp/views/widgets/gradientbox.dart';

import '../../main.dart';
import '../widgets/loginwidgets/bottombarwidget.dart';
import '../widgets/loginwidgets/headingmessage.dart';
import '../widgets/loginwidgets/textfieldwidget.dart';
import 'onboardinghome.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final _emailController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
   
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
       SystemChrome.setSystemUIOverlayStyle(
       const SystemUiOverlayStyle(
         statusBarColor: Color.fromARGB(255, 255, 255, 255),
         statusBarIconBrightness: Brightness.dark,
        
      )
    );
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
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>OnboardingHome()));

                        },
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Expanded(
                      flex: 6,
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: (MediaQuery.of(context).size.height) * 0.75,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                child: Column(
                                  children: [
                                    TextFieldWidget(
                                      hint: "Enter Email Address",
                                      label: "Email Address",
                                      textController: _emailController,
                                      typeValue: TextInputType.emailAddress,
                                    ),
                                    Align(
                                      child: GradientBox(
                                        colorStart: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        colorEnd: const Color.fromARGB(
                                            255, 4, 209, 206),
                                        gradFunction: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            bool result =
                                                await checkIfUserExist(context);
                                            if (result == true) {
                                              await viewModel.addToCategList();
                                              await viewModel.addToTaskList();
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (ctx) =>
                                                              const ScreenHome()));
                                            } else {
                                              var snackBar = const SnackBar(
                                                content: Text(
                                                  'Oops!!Looks like you are not registered. Sign Up to continue :)',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                backgroundColor: Colors.red,
                                                padding: EdgeInsets.all(20),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }
                                          } else {
                                            debugPrint('Empty field found');
                                          }
                                        },
                                        textVal: "Log In",
                                        textColor: const Color(0xff011638),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: BottomTextButton(
                                        linkText: 'Sign Up',
                                        function: () => Navigator.of(context)
                                            .pushReplacement(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ScreenSignUp()),
                                    ))),
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
    });
  }

  Future<bool> checkIfUserExist(BuildContext ctx) async {
    final email = _emailController.text.trim();

    List<Map<String, dynamic>> out = await Repository.fetchData(email);
    debugPrint("User Exists status on Login - ${out.toString()}");
    if (out.isNotEmpty) {
      Map val = out[0];
      await Repository.setCurrentUser(
          val['uid'], val['name'], val['email'], val['photo']);
      //setting value of savekeyname to true when credentials are correct.
      final sharedPrefs = await SharedPreferences.getInstance();
      await sharedPrefs.setString(SAVE_KEY_NAME, email);
      

      await Repository.getAllUser();

      return true;
    } else {
      return false;
    }
  }
}
