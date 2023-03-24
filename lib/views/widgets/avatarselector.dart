import 'package:flutter/material.dart';

List avatarImages = [
  'assets/images/avatars01.png',
  'assets/images/avatars02.png',
  'assets/images/avatars03.png',
  'assets/images/avatars04.png',
  'assets/images/avatars05.png',
  'assets/images/avatars06.png',
  'assets/images/avatars07.png',
  'assets/images/avatars08.png',
];

/* avatarSelector(BuildContext ctx) {
  return showDialog(
      context: ctx,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: Colors.white,
          children: [
            GridView.count(
              crossAxisCount: 2,
              children: List.generate(avatarImages.length, (index) {
                return GestureDetector(
                  onTap: () {
                    
                  },
                  child: Card(
                    //clipBehavior: Clip.antiAliasWithSaveLayer,
                
                    child: Image(image: AssetImage(avatarImages[index])),
                  ),
                );
              }),
            ),
        ]);
      });
}
 */