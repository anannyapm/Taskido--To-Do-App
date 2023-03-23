import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:provider/provider.dart';

import '../../../viewmodel/appviewmodel.dart';

class StreakBarWidget extends StatefulWidget {
  const StreakBarWidget({
    super.key,
  });

  @override
  State<StreakBarWidget> createState() => _StreakBarWidgetState();
}

class _StreakBarWidgetState extends State<StreakBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      double streakval = viewModel.completedCount == 0
          ? 0
          : viewModel.completedCount / viewModel.totalTaskCount;
      List streakdata = streakMessage(streakval);
      return Align(
        alignment: const Alignment(-1, 1),
        child: Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.85),
          height: 50,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
              //color: Color(0xff011638)
              gradient: LinearGradient(colors: [Color(0xff00a9a5),Color(0xff011638),Colors.black])
              ),
          child: Container(
            margin: const EdgeInsets.only(left: 25),
            child: Row(
              children: [
                Text(
                  streakdata[0],
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.white),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xffFFFFFF), Color.fromARGB(255, 249, 186, 14)],
                      ).createShader(bounds);
                    },
                    child: streakdata[1],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  List streakMessage(double streakval) {
    if (streakval == 0) {
      return ['Time to start with tasks!', Icon(
                      FontAwesome5.smile_beam,
                      color: Color.fromARGB(255, 248, 206, 0),
                      size: 25,
                    )];
    } else if (streakval <= 0.30) {
      return ['You are lagging behind',Icon(
                      FontAwesome5.sad_tear,
                      color: Color.fromARGB(255, 246, 177, 137),
                      size: 25,
                    ) ];
    } else if (streakval <= 0.6) {
      return ['Good Going my friend', Icon(
                      FontAwesome5.smile_wink,
                      color: Colors.white,
                      size: 25,
                    ) ];
    } else {
      return ['You are on Streak', Icon(
                      FontAwesome5.fire,
                      color: Color.fromARGB(255, 255, 114, 71),
                      size: 25,
                    ) ];
    }
  }
}
