import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:todoapp/functions/string_extensions.dart';
import 'package:todoapp/views/widgets/homewidgets/indicator.dart';

import '../../../constants/colorconstants.dart';


class CategoryGraph extends StatefulWidget {
  final int pendingTodayCount;
  final int totalCount;
  final int completedCount;
  final int totalTodayCount;
  final String categoryName;

  const CategoryGraph({
    super.key,
    required this.pendingTodayCount,
    required this.totalTodayCount,
    required this.totalCount,
    required this.completedCount,
    required this.categoryName,
  });

  @override
  State<CategoryGraph> createState() => _CategoryGraphState();
}

class _CategoryGraphState extends State<CategoryGraph> {
  int progresstouchedIndex = -1;
  int overalltouchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    double completedPercent = widget.totalCount == 0
        ? 0
        : widget.completedCount / widget.totalCount * 100;
    double pendingTodayPercent = widget.totalTodayCount == 0
        ? 0
        : widget.pendingTodayCount / widget.totalTodayCount * 100;

    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.all(20),
      
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 20),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      Border.all(color:  pClr3Shade1)),
              child: IconButton(
                icon:  Icon(
                  Icons.arrow_back_ios_outlined,
                  color: primaryclr3,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Container(
              height: 45,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12)),
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(12, 18, 5, 82),
                    Color.fromARGB(33, 0, 169, 166)
                  ])),
              child: Center(
                child: Text(
                  widget.categoryName.toTitleCase(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  const Text(
                    'Today\'s Progress',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Indicator(
                      color1: chart1Color1,
                      text1: 'Completed Count',
                      text2: 'Pending Count',
                      color2: chart1Color2)
                ],
              ),
            ),
            
           
            
            //Chart One -- Overall Progress
            widget.totalTodayCount==0?const Padding(
              padding: EdgeInsets.all(50),
              child: Center(child:Text('No Tasks Found',style: TextStyle(fontSize: 18),)),
            ): Expanded(
              child:pieChartWidget(pendingTodayPercent,  chart1Color1, chart1Color2, 0)

            ),

             const SizedBox(height: 30,),
            Padding(
                            padding: const EdgeInsets.only(top: 10,bottom: 20),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                 const Text(
                    'Overall Status',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Indicator(
                      color1: chart2Color1,
                      text1: 'Completed Count',
                      text2: 'Pending Count',
                      color2: chart2Color2)
                ],
              ),
            ),
            Expanded(
              child:widget.totalCount==0?const Padding(
              padding: EdgeInsets.all(50),
              child: Center(child:Text('No Tasks Found',style: TextStyle(fontSize: 18),)),
            ):pieChartWidget(completedPercent,chart2Color2, chart2Color1,1)
             
            ),
          ],
        ),
      )),
    );
  }

  Widget pieChartWidget(
      double valuePercent, Color colorComplete, Color colorPending,int chartid) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: PieChart(PieChartData(
          centerSpaceRadius: 0,
          startDegreeOffset: 180,
          borderData: FlBorderData(show: false),
          sectionsSpace: 1,
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  progresstouchedIndex = -1;
                  return;
                }
                progresstouchedIndex =
                    pieTouchResponse.touchedSection!.touchedSectionIndex;
              });
            },
          ),
          sections: [
            PieChartSectionData(
              value: valuePercent,
              color: colorPending,
              radius: (valuePercent == 50 || valuePercent == 100)
                  ? 80
                  : 60,
              titlePositionPercentageOffset: 0.55,
              title:chartid==0? '${widget.pendingTodayCount} Task':'${widget.completedCount} Task',
              titleStyle:  TextStyle(color: primaryclr4),
              borderSide: progresstouchedIndex == 0
                  ?  BorderSide(color: primaryclr4, width: 6)
                  : const BorderSide(color: Color(0x00FFFFFF)),
            ),
            PieChartSectionData(
              value: 100 - valuePercent,
              color: colorComplete,
              radius: (100 - valuePercent == 50 ||
                      100 - valuePercent == 100)
                  ? 80
                  : 60,
              titlePositionPercentageOffset: 0.55,
              title: chartid==0?'${widget.totalTodayCount - widget.pendingTodayCount} Task':'${widget.totalCount-widget.completedCount} Task',
              titleStyle:  TextStyle(color: primaryclr4),
              borderSide: progresstouchedIndex == 1
                  ?  BorderSide(color: primaryclr4, width: 6)
                  :  const BorderSide(color: Color(0x00FFFFFF)),
            ),
          ])),
    );
  }
}
