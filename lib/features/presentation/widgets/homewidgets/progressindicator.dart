import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:todoapp/features/presentation/bloc/taskbloc/task_bloc.dart';
import 'package:todoapp/features/presentation/constants/colorconstants.dart';

import '../../bloc/taskbloc/task_state.dart';

class ProgressIndicatorWidget extends StatefulWidget {
  const ProgressIndicatorWidget({
    super.key,
  });

  @override
  State<ProgressIndicatorWidget> createState() =>
      _ProgressIndicatorWidgetState();
}

class _ProgressIndicatorWidgetState extends State<ProgressIndicatorWidget> {
  double max = 0;
  double progressValue = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state is TaskLoadingState) {
          max = /* state.totalTaskCount.toDouble() == 0
              ? 1
              : */ state.totalTaskCount.toDouble();
          progressValue = state.completedCount.toDouble();
        }
      },
      builder: ((context, state) {
        return Container(
          margin: const EdgeInsets.only(left: 25, right: 25, top: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //gaugecode

              SizedBox(
                width: 120,
                height: 120,
                child: SfRadialGauge(
                    enableLoadingAnimation: true,
                    animationDuration: 4500,
                    axes: <RadialAxis>[
                      RadialAxis(
                          minimum: 0,
                          maximum: max==0?1:max,
                          showLabels: false,
                          showTicks: false,
                          startAngle: 270,
                          endAngle: 270,
                          axisLineStyle: const AxisLineStyle(
                            thickness: 0.1,
                            cornerStyle: CornerStyle.bothFlat,
                            color: Color(0xFFDCDEE2),
                            thicknessUnit: GaugeSizeUnit.factor,
                          ),
                          pointers: <GaugePointer>[
                            RangePointer(
                                value: progressValue,
                                width: 0.1,
                                sizeUnit: GaugeSizeUnit.factor,
                                cornerStyle: CornerStyle.startCurve,
                                gradient: SweepGradient(colors: <Color>[
                                  const Color(0xFF00FFFF),
                                  primaryclr1
                                ], stops: const [
                                  0.25,
                                  0.75
                                ])),
                            MarkerPointer(
                              value: progressValue,
                              markerType: MarkerType.circle,
                              markerHeight: 15,
                              markerWidth: 15,
                              color: primaryclr1,
                            )
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                                angle: 90,
                                widget: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '${((max == 0 ? 0 : (progressValue / max) * 100)).toStringAsFixed(0)}%\n',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                          height: 1.5,
                                          color: primaryclr1,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Efficieny',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          height: 1.5,
                                          color: primaryclr1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                          ])
                    ]),
              ),

              //gaugecode end

              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          '${(max - progressValue).toInt()} ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        color: primaryclr1,
                      ),
                    ),
                    TextSpan(
                      text: 'Live Task awaiting',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        height: 1.5,
                        color: primaryclr1,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
