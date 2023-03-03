import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

class StreakBarWidget extends StatelessWidget {
  const StreakBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
                    alignment: const Alignment(-1, 1),
                    child: Container(
                      width: 300,
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
                            const Text(
                              'You are on Streak',
                              style: TextStyle(
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
                                child: const Icon(
                                  FontAwesome5.fire,
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
  }
}