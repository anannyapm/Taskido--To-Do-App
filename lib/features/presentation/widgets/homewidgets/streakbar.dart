import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todoapp/features/presentation/constants/colorconstants.dart';

import '../../bloc/taskbloc/task_bloc.dart';
import '../../bloc/taskbloc/task_state.dart';

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
    double streakval = 0;
    List streakdata = streakMessage(0);
    return BlocConsumer<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state is TaskLoadingState) {
          streakval = state.completedCount == 0
              ? 0
              : state.completedCount / state.totalTaskCount;
          streakdata = streakMessage(streakval);
        } /* else {
          BlocProvider.of<TaskBloc>(context).add(LoadTaskEvent());
        } */
      },
      builder: (context, state) {
        return Align(
          alignment: const Alignment(-1, 1),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
                //color: primaryclr1
                gradient: LinearGradient(
                    colors: [primaryclr2, primaryclr1, primaryclr3])),
            child: Container(
              constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width * 0.5,
                  maxWidth: MediaQuery.of(context).size.width * 0.85),
              margin: const EdgeInsets.only(left: 25),
              child: Row(
                children: [
                  Text(
                    streakdata[0],
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: primaryclr4),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
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
      },
    );
  }

  List streakMessage(double streakval) {
    if (streakval == 0) {
      return [
        'Time to start with tasks!',
        const Icon(
          Icons.sentiment_very_satisfied,
          color: Color(0xFFF8CE00),
          size: 25,
        )
      ];
    } else if (streakval <= 0.30) {
      return [
        'You are lagging behind',
        const Icon(
          Icons.sentiment_dissatisfied,
          color: Color(0xFFF6B189),
          size: 25,
        )
      ];
    } else if (streakval <= 0.6) {
      return [
        'Good Going my friend',
        Icon(
          Icons.sentiment_satisfied_alt,
          color: primaryclr4,
          size: 25,
        )
      ];
    } else {
      return [
        'You are on Streak',
        const Icon(
          Icons.local_fire_department,
          color: Color(0xFFFF7247),
          size: 25,
        )
      ];
    }
  }
}
