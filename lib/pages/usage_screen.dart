import 'package:flutter/material.dart';

class Usage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Padding(
        padding : const EdgeInsets.all(30),
        child :
        //usage text
        new Text(
        "Click on the Floating Action Button to open camera and point it towards the insect you wish to detect.",
        style: new TextStyle(fontSize: 25.0),
        textAlign: TextAlign.center,
      ),
    ),
   );
  }
}
