import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../screens/home.dart';

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
                margin: const EdgeInsets.all(20),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.all(15),
                child: SizedBox(
                  width: 80,
                  height: 80,
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
                  const Text(
                    'Hey!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff011638),
                    ),
                  ),
                  const Text(
                    'Greta',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
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
                  icon: const Icon(Icons.menu)))
        ],
      ),
    );
  }
}
