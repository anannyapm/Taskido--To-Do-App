import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ProgressIndicatorWidget extends StatefulWidget {
  final double progressVal;
  final double maxVal;
  const ProgressIndicatorWidget(
      {super.key, this.maxVal = 100, required this.progressVal});

  @override
  State<ProgressIndicatorWidget> createState() =>
      _ProgressIndicatorWidgetState();
}

class _ProgressIndicatorWidgetState extends State<ProgressIndicatorWidget> {
  @override
  Widget build(BuildContext context) {
    double progressValue = widget.progressVal;
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
                      //centerX: 0.28,
                      //centerY: 0.3,
                      maximum: widget.maxVal,
                      showLabels: false,
                      showTicks: false,
                      startAngle: 270,
                      endAngle: 270,
                      //radiusFactor: 0.4,
                      axisLineStyle: AxisLineStyle(
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
                            gradient: const SweepGradient(colors: <Color>[
                              Color(0xFF00FFFF),
                              Color(0xFF011638)
                            ], stops: <double>[
                              0.25,
                              0.75
                            ])),
                        MarkerPointer(
                          value: progressValue,
                          markerType: MarkerType.circle,
                          markerHeight: 15,
                          markerWidth: 15,
                          color: const Color(0xFF011638),
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
                                        ((progressValue / widget.maxVal) * 100)
                                                .toStringAsFixed(0) +
                                            '%\n',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      height: 1.5,
                                      color: Color(0xff011638),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Efficieny',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5,
                                      color: Color(0xff011638),
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
                  text: '14 ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    color: Color(0xff011638),
                  ),
                ),
                TextSpan(
                  text: 'Live Tasks awaiting',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    height: 1.5,
                    color: Color(0xff011638),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
