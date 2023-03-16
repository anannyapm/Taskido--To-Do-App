import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:provider/provider.dart';

import '../../../viewmodel/appviewmodel.dart';

class StreakBarWidget extends StatefulWidget {
  //final double streakval;
  const StreakBarWidget({
    super.key,
    //required this.streakval
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
          height: 55,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
              color: Color(0xff011638)),
          child: Container(
            margin: const EdgeInsets.only(left: 25),
            child: Row(
              children: [
                Text(
                  streakdata[0],
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                      color: Colors.white),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xffFFFFFF), Color(0xffFF1F00)],
                      ).createShader(bounds);
                    },
                    child: Icon(
                      streakdata[1],
                      color: Colors.white,
                      size: 25,
                    ),
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
      return ['Time to start with tasks!', FontAwesome5.smile_beam];
    } else if (streakval <= 0.30) {
      return ['You are lagging behind', FontAwesome5.sad_tear];
    } else if (streakval <= 0.6) {
      return ['Good Going my friend', FontAwesome5.smile_wink];
    } else {
      return ['You are on Streak', FontAwesome5.fire];
    }
  }
}
