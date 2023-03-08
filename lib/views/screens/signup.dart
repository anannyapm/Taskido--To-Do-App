import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/dbfunctions/repository.dart';
import 'package:todoapp/models/usermodel.dart';
import 'package:todoapp/views/screens/home.dart';
import 'package:todoapp/views/screens/login.dart';
import 'package:todoapp/views/widgets/gradientbox.dart';

import '../../functions/helper.dart';
import '../../models/appviewmodel.dart';
import '../widgets/loginwidgets/bottombarwidget.dart';
import '../widgets/loginwidgets/headingmessage.dart';
import '../widgets/loginwidgets/textfieldwidget.dart';

class ScreenSignUp extends StatefulWidget {
  const ScreenSignUp({super.key});

  @override
  State<ScreenSignUp> createState() => _ScreenSignUpState();
}

class _ScreenSignUpState extends State<ScreenSignUp> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
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
            //add singlechildscrollview
            body: Container(
                height: MediaQuery.of(context).size.height,
                //add height
                margin: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      //height: (MediaQuery. of(context). size. height)*0.1,

                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          //borderRadius: BorderRadius.circular(50),
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
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          height: (MediaQuery.of(context).size.height) * 0.75,
                          margin: const EdgeInsets.only(top: 50),
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              const HeadingMessage(
                                heading: "Hello There!\n",
                                subheading: "Let's get you onboarded.",
                              ),

                              /*  const SizedBox(
                              height: 30,
                            ), */

                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 20, top: 20),
                                child: Align(
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      viewModel.profilePhoto?.path == null
                                          ? const CircleAvatar(
                                              radius: 35,
                                              backgroundColor:
                                                  Color.fromARGB(255, 9, 9, 9),
                                              child: CircleAvatar(
                                                radius: 33,
                                                backgroundImage: AssetImage(
                                                    'assets/images/stacked-steps-haikei.png'),
                                              ),
                                            )
                                          : CircleAvatar(
                                              radius: 35,
                                              backgroundColor:
                                                  Color.fromARGB(255, 9, 9, 9),
                                              child: CircleAvatar(
                                                radius: 33,
                                                backgroundImage: FileImage(File(
                                                    viewModel
                                                        .profilePhoto!.path)),
                                              ),
                                            ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                        padding: const EdgeInsets.all(2),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  Color.fromARGB(255, 1, 1, 1)),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.edit,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              viewModel.getPhoto();
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Form(
                                key: _formKey,

                                //child: Expanded(
                                child: Column(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextFieldWidget(
                                      hint: "Enter User Name",
                                      label: "User Name",
                                      textController: _usernameController,
                                    ),
                                    /* const SizedBox(
                                    height: 20,
                                  ), */
                                    TextFieldWidget(
                                      hint: "Enter Email Address",
                                      label: "Email Address",
                                      textController: _emailController,
                                      typeValue: TextInputType.emailAddress,
                                    ),
                                    /* const SizedBox(
                                    height: 20,
                                  ), */
                                    Align(
                                      child: GradientBox(
                                        colorStart: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        colorEnd: const Color(0xFF04D1CE),
                                        gradFunction: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            addUserToModel(
                                                viewModel.profilePhoto,context);

                                            _usernameController.text = '';
                                            _emailController.text = '';


                                          } else {
                                            debugPrint('Empty fields found');
                                          }
                                        },
                                        textVal: "Sign Up",
                                        textColor: const Color(0xff011638),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              Expanded(
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: BottomTextButton(
                                      linkText: 'Log In',
                                      function: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  const ScreenLogin())),
                                    )),
                              )
                              //),
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

  Future<void> addUserToModel(File? profilephoto,BuildContext ctx) async {
    final _name = _usernameController.text.trim();
    final _email = _emailController.text.trim();
    File? _photo = File('assets/images/stacked-steps-haikei.png');

    final _image = profilephoto;

    if (_image != null) {
      _photo = _image;
    }

    final _userObject = UserModel(_name, _email, _photo.path.toString());

    /* print("$_name $_email before calling savedata"); */

    dynamic out = await Repository.saveData(_userObject);
    if(out==true){
      Repository.setCurrentUser(_name, _email,  _photo.path.toString());
      Navigator.of(ctx)
          .push(MaterialPageRoute(builder: (context) => const ScreenHome()));}

    else{
      var snackBar = SnackBar(
        content: Text(
          'This email id is already registered. Please Login back to continue!',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        padding: EdgeInsets.all(20),
      );
      ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
    }
    debugPrint(out.toString());

  }
}
