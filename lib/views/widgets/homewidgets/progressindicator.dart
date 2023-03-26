import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:todoapp/constants/colorconstants.dart';

import '../../../viewmodel/appviewmodel.dart';

class ProgressIndicatorWidget extends StatefulWidget {
  const ProgressIndicatorWidget({
    super.key,
  });

  @override
  State<ProgressIndicatorWidget> createState() =>
      _ProgressIndicatorWidgetState();
}

class _ProgressIndicatorWidgetState extends State<ProgressIndicatorWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      double max = viewModel.totalTaskCount.toDouble() == 0
          ? 1
          : viewModel.totalTaskCount.toDouble();
      double progressValue = viewModel.completedCount.toDouble();
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
                        maximum: max,
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
                              gradient:  SweepGradient(colors: <Color>[
                                Color(0xFF00FFFF),
                                primaryclr1
                              ], stops: <double>[
                                0.25,
                                0.75
                              ])),
                          MarkerPointer(
                            value: progressValue,
                            markerType: MarkerType.circle,
                            markerHeight: 15,
                            markerWidth: 15,
                            color:  primaryclr1,
                          )
                        ],
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                              //positionFactor: 0,
                              angle: 90,
                              widget: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          '${((max == 0 ? 0 : (progressValue / max) * 100)).toStringAsFixed(0)}%\n',
                                      style:  TextStyle(
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
                        '${viewModel.totalTaskCount - viewModel.completedCount} ',
                    style:  TextStyle(
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
    });
  }
}
