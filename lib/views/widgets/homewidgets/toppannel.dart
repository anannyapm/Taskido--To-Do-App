import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../screens/home.dart';
import '../../screens/profilehome.dart';

class TopPanelWidget extends StatefulWidget {
  

  const TopPanelWidget({super.key});

  @override
  State<TopPanelWidget> createState() => _TopPanelWidgetState(
    
  );
}

class _TopPanelWidgetState extends State<TopPanelWidget> {
  @override
  Widget build(BuildContext context) {
    
    return Container(
                margin: const EdgeInsets.fromLTRB(10,20,10,10),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.all(15),
                child: SizedBox(
                  width: 75,
                  height: 75,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: const DecorationImage(
                            image: AssetImage('assets/images/profileImage.jpg'),
                            fit: BoxFit.cover)),
                  ),
                ),
              ),
              Column(
                //text: const TextSpan(
                crossAxisAlignment: CrossAxisAlignment.start,
                
                
                // ignore: prefer_const_literals_to_create_immutables
                children: [
              /* 
                  RichText(
                        textAlign: TextAlign.center,
                        text:  TextSpan(
                          children: [
                            TextSpan(
                              text:'Hey!\n',
                              
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                                color: Color(0xff011638),
                              ),
                            ),
                            
                            TextSpan(
                              text: 'Greta',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                height: 1.5,
                                color: Color(0xff011638),
                              ),
                            ),
                          ],
                        ),
                                  
                    ), */
              
                  const Text(
                    'Hey!',
                    style: TextStyle(
                      fontSize: 18,
                      //height: 0.5,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff011638),
                    ),
                  ),
                  const Text(
                    'Greta',
                    style: TextStyle(
                      fontSize: 28,
                      height: 1.1,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff011638),
                    ),
                  ),
                ],
              ),
              //),
            ],
          ),
          Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  onPressed: () {
                    drawerkey.currentState!.openEndDrawer();
                  },
                  icon: const Icon(Icons.menu,size: 30,)))
        ],
      ),
    );
  }
}
