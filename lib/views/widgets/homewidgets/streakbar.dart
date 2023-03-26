import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/constants/colorconstants.dart';

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
          decoration:  BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
              //color: primaryclr1
              gradient: LinearGradient(colors: [ primaryclr2,primaryclr1,primaryclr3])
              ),
          child: Container(
            margin: const EdgeInsets.only(left: 25),
            child: Row(
              children: [
                Text(
                  streakdata[0],
                  style:  TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: primaryclr4),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return  LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [primaryclr4, const Color(0xFFF9BA0E)],
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
      return ['Time to start with tasks!', const Icon(
                      FontAwesome5.smile_beam,
                      color: Color(0xFFF8CE00),
                      size: 25,
                    )];
    } else if (streakval <= 0.30) {
      return ['You are lagging behind',const Icon(
                      FontAwesome5.sad_tear,
                      color: Color(0xFFF6B189),
                      size: 25,
                    ) ];
    } else if (streakval <= 0.6) {
      return ['Good Going my friend', Icon(
                      FontAwesome5.smile_wink,
                      color: primaryclr4,
                      size: 25,
                    ) ];
    } else {
      return ['You are on Streak', const Icon(
                      FontAwesome5.fire,
                      color: Color(0xFFFF7247),
                      size: 25,
                    ) ];
    }
  }
}
