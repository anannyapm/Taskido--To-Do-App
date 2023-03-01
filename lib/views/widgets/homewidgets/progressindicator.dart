import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ProgressIndicatorWidget extends StatefulWidget {
  const ProgressIndicatorWidget({super.key});

  @override
  State<ProgressIndicatorWidget> createState() =>
      _ProgressIndicatorWidgetState();
}

class _ProgressIndicatorWidgetState extends State<ProgressIndicatorWidget> {
  @override
  Widget build(BuildContext context) {
    double progressValue = 28;
    return SfRadialGauge(axes: <RadialAxis>[
      RadialAxis(
        minimum: 0,
        maximum: 100,
        showLabels: false,
        showTicks: false,
        axisLineStyle: AxisLineStyle(
          thickness: 0.2,
          cornerStyle: CornerStyle.bothCurve,
          color: Color.fromARGB(30, 0, 169, 181),
          thicknessUnit: GaugeSizeUnit.factor,
        ),
        pointers: <GaugePointer>[
          RangePointer(
            value: progressValue,
            cornerStyle: CornerStyle.bothCurve,
            width: 0.2,
            sizeUnit: GaugeSizeUnit.factor,
          )
        ],
        annotations: <GaugeAnnotation>[
  GaugeAnnotation(
  positionFactor: 0.1,
  angle: 90,
  widget: Text(
  progressValue.toStringAsFixed(0) + ' / 100',
  style: TextStyle(fontSize: 11),
  ))
  ])
      
    ]);
  }
}
