import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/features/presentation/bloc/categorybloc/category_bloc.dart';
import 'package:todoapp/features/presentation/bloc/categorybloc/category_event.dart';
import 'package:todoapp/features/presentation/bloc/photobloc/photo_bloc.dart';
import 'package:todoapp/features/presentation/bloc/photobloc/photo_event.dart';
import 'package:todoapp/features/presentation/bloc/photobloc/photo_state.dart';
import 'package:todoapp/features/presentation/bloc/taskbloc/task_bloc.dart';
import 'package:todoapp/features/presentation/bloc/taskbloc/task_event.dart';
import 'package:todoapp/features/presentation/bloc/userbloc/user_bloc.dart';
import 'package:todoapp/features/presentation/bloc/userbloc/user_event.dart';
import 'package:todoapp/features/presentation/pages/home.dart';
import 'package:todoapp/features/presentation/pages/login.dart';
import 'package:todoapp/features/presentation/pages/onboardinghome.dart';
import 'package:todoapp/features/presentation/constants/avatars.dart';
import 'package:todoapp/features/presentation/widgets/gradientbox.dart';
import 'package:todoapp/features/presentation/widgets/snackbar.dart';
import '../bloc/userbloc/user_state.dart';
import '../constants/colorconstants.dart';
import '../../../viewmodel/appviewmodel.dart';
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
  String photo = "assets/images/stacked-steps-haikei.png'";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: primaryclr4,
      statusBarIconBrightness: Brightness.dark,
    ));
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            color: primaryclr4,
            image: const DecorationImage(
              alignment: Alignment.topRight,
              image: AssetImage('assets/images/Vector2.png'),
              scale: 1.5,
            )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
              height: MediaQuery.of(context).size.height,
              //add height
              margin: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: pClr3Shade1)),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_outlined,
                        color: primaryclr3,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const OnboardingHome()));
                      },
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        height: (MediaQuery.of(context).size.height) * 0.75,
                        margin: const EdgeInsets.only(top: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const HeadingMessage(
                              heading: "Hello There!\n",
                              subheading: "Let's get you onboarded.",
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 20, top: 20),
                              child: Align(
                                child: BlocConsumer<PhotoBloc, PhotoState>(
                                  listener: (context, state) {
                                    if (state is PhotoLoaded) {
                                      photo = state.photo == ""
                                          ? 'assets/images/stacked-steps-haikei.png'
                                          : state.photo;
                                    }
                                    if (state is PhotoResetEvent) {
                                      photo =
                                          'assets/images/stacked-steps-haikei.png';
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is PhotoLoaded) {
                                      return Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          state.photo == ''
                                              ? CircleAvatar(
                                                  radius: 35,
                                                  backgroundColor: pClr3Shade2,
                                                  child: const CircleAvatar(
                                                    radius: 34,
                                                    backgroundImage: AssetImage(
                                                        'assets/images/stacked-steps-haikei.png'),
                                                  ),
                                                )
                                              : CircleAvatar(
                                                  radius: 35,
                                                  backgroundColor: pClr3Shade2,
                                                  child: CircleAvatar(
                                                    radius: 34,
                                                    backgroundColor:
                                                        primaryclr4,
                                                    backgroundImage:
                                                        AssetImage(state.photo),
                                                  ),
                                                ),
                                          Container(
                                            height: 34,
                                            width: 34,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: primaryclr4),
                                            padding: const EdgeInsets.all(2),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: primaryclr3),
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.edit,
                                                  size: 18,
                                                  color: primaryclr4,
                                                ),
                                                padding: EdgeInsets.zero,
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (BuildContext ctx) {
                                                        return AlertDialog(
                                                          title: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              const Text(
                                                                  'Select your Avatar'),
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    BlocProvider.of<PhotoBloc>(
                                                                            context)
                                                                        .add(PhotoSelectedEvent(
                                                                            photo:
                                                                                'assets/images/stacked-steps-haikei.png'));
                                                                    /*  viewModel
                                                                        .setProfile(
                                                                            'assets/images/stacked-steps-haikei.png'); */
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: const Text(
                                                                      'Clear')),
                                                            ],
                                                          ),
                                                          content: SizedBox(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.6,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.8,
                                                            child: GridView(
                                                              shrinkWrap: true,
                                                              physics:
                                                                  const ClampingScrollPhysics(),
                                                              gridDelegate:
                                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    2,
                                                              ),
                                                              children:
                                                                  List.generate(
                                                                      avatarImages
                                                                          .length,
                                                                      (index) {
                                                                return GestureDetector(
                                                                  onTap: () {
                                                                    BlocProvider.of<PhotoBloc>(
                                                                            context)
                                                                        .add(PhotoSelectedEvent(
                                                                            photo:
                                                                                avatarImages[index]));
                                                                    /*  viewModel.setProfile(
                                                                        avatarImages[
                                                                            index]); */
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Card(
                                                                    child: Image.asset(
                                                                        avatarImages[
                                                                            index]),
                                                                  ),
                                                                );
                                                              }),
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    return Container();
                                  },
                                ),
                              ),
                            ),
                            BlocListener<UserBloc, UserState>(
                              listener: (context, state) {
                                if (state is SignupFailure) {
                                  snackBarWidget(
                                      context, state.errorMessage, Colors.red);
                                } else if (state is SignupSuccess) {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ScreenHome()),
                                      (route) => false);
                                }
                              },
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFieldWidget(
                                      hint: "Enter User Name",
                                      label: "User Name",
                                      textController: _usernameController,
                                      typeValue: TextInputType.name,
                                    ),
                                    TextFieldWidget(
                                      hint: "Enter Email Address",
                                      label: "Email Address",
                                      textController: _emailController,
                                      typeValue: TextInputType.emailAddress,
                                    ),
                                    Align(
                                      child: GradientBox(
                                        colorStart: primaryclr4,
                                        colorEnd: pClr2Shade1,
                                        gradFunction: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            final name = _usernameController
                                                .text
                                                .trim()
                                                .replaceAll(
                                                    RegExp(r"\s+"), " ");
                                            final email =
                                                _emailController.text.trim();

                                            BlocProvider.of<UserBloc>(context)
                                                .add(SignUpEvent(
                                                    name: name,
                                                    email: email,
                                                    photo: photo));
                                            BlocProvider.of<CategoryBloc>(
                                                    context)
                                                .add(LoadCategoryEvent());
                                            BlocProvider.of<TaskBloc>(context)
                                                .add(LoadTaskEvent());
                                            // await viewModel.addToCategList();
                                            // await viewModel.addToTaskList();
                                            _usernameController.text = '';
                                            _emailController.text = '';
                                            //viewModel.setProfile('');
                                          } else {
                                            debugPrint('Empty fields found');
                                          }
                                        },
                                        textVal: "Sign Up",
                                        textColor: primaryclr1,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: BottomTextButton(
                                    linkText: 'Log In',
                                    function: () => Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                            builder: (context) =>
                                                const ScreenLogin())),
                                  )),
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
