import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/functions/string_extensions.dart';
import 'package:todoapp/views/widgets/homewidgets/indicator.dart';

import '../../../viewmodel/appviewmodel.dart';

class CategoryGraph extends StatefulWidget {
  final int pendingTodayCount;
  final int totalCount;
  final int completedCount;
  final String categoryName;
  
  const CategoryGraph(
      {super.key,
      required this.pendingTodayCount,
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
  double completedPercent=widget.completedCount/widget.totalCount*100;
  double pendingTodayPercent=widget.pendingTodayCount/widget.totalCount*100;


    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        body: SafeArea(
            child: Container(
          margin: const EdgeInsets.all(20),
          //padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: const Color.fromARGB(107, 51, 51, 51))),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.black,
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Today\'s Progress',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Indicator(
                      color1: Color(0xFF00576D),
                      text1: 'Completed Count',
                      text2: 'Pending Count',
                      color2: Color(0xFF00B3FF))
                ],
              ),

              //Chart One -- Todays Progress
              Expanded(
                
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
                          progresstouchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    sections: [
                      PieChartSectionData(
                        value: pendingTodayPercent,
                        color: const Color(0xFF00576D),
                        radius: (pendingTodayPercent == 50 ||
                                pendingTodayPercent == 100)
                            ? 100
                            : 80,
                        titlePositionPercentageOffset: 0.55,
                        title:
                            '${widget.pendingTodayCount}',
                        titleStyle: const TextStyle(color: Colors.white),
                        borderSide: progresstouchedIndex == 0
                            ? const BorderSide(color: Colors.white, width: 6)
                            : const BorderSide(
                                color: Color.fromARGB(0, 255, 255, 255)),
                      ),
                      PieChartSectionData(
                        value: 100 - pendingTodayPercent,
                        color: const Color(0xFF00B3FF),
                        radius: (100 - pendingTodayPercent == 50 ||
                                100 - pendingTodayPercent == 100)
                            ? 100
                            : 90,
                        titlePositionPercentageOffset: 0.55,
                        title: '${widget.totalCount- widget.pendingTodayCount}',
                        titleStyle: const TextStyle(color: Colors.white),
                        borderSide: progresstouchedIndex == 1
                            ? const BorderSide(color: Colors.white, width: 6)
                            : const BorderSide(
                                color: Color.fromARGB(0, 255, 255, 255)),
                      ),
                    ])),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Overall Status',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Indicator(
                      color1: Color(0xFF06D4B2),
                      text1: 'Completed %',
                      text2: 'Pending %',
                      color2: Color(0xFF015D5D))
                ],
              ),
              Expanded(
                //height: MediaQuery.of(context).size.height*0.5,
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
                            overalltouchedIndex = -1;
                            return;
                          }
                          overalltouchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    sections: [
                      PieChartSectionData(
                        value: completedPercent,
                        color: const Color(0xFF06D4B2),
                        radius: (completedPercent == 50 ||
                                completedPercent == 100)
                            ? 100
                            : 80,
                        titlePositionPercentageOffset: 0.55,
                        title: '${completedPercent}%',
                        titleStyle: const TextStyle(color: Colors.white),
                        borderSide: overalltouchedIndex == 0
                            ? const BorderSide(color: Colors.white, width: 6)
                            : const BorderSide(
                                color: Color.fromARGB(0, 255, 255, 255)),
                      ),
                      PieChartSectionData(
                        value: 100 - completedPercent,
                        color: const Color(0xFF015D5D),
                        radius: (100 - completedPercent == 50 ||
                                100 - completedPercent == 100)
                            ? 100
                            : 90,
                        titlePositionPercentageOffset: 0.55,
                        title: '${100 - completedPercent}%',
                        titleStyle: const TextStyle(color: Colors.white),
                        borderSide: overalltouchedIndex == 1
                            ? const BorderSide(color: Colors.white, width: 6)
                            : const BorderSide(
                                color: Color.fromARGB(0, 255, 255, 255)),
                      ),
                    ])),
              ),
            ],
          ),
        )),
      );
    });
  }
}
