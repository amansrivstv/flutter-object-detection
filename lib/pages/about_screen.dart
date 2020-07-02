import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    new CircleAvatar(
      radius: 80,
                  foregroundColor: Theme.of(context).primaryColor,
                  backgroundColor: Colors.grey,
      //institute logo
                  backgroundImage: new NetworkImage("https://scontent.fknu1-1.fna.fbcdn.net/v/t1.0-9/p960x960/50652032_2040680209311772_1832502768124821504_o.png?_nc_cat=106&_nc_sid=85a577&_nc_ohc=f_rytYnaXUIAX-mqOWy&_nc_ht=scontent.fknu1-1.fna&oh=6038357652221afe35f5baef2d491733&oe=5EE91DD5"),
                ),
    Center(
      child: Padding(
        padding : const EdgeInsets.all(30),
        child :
        //text in about
        new Text(
        "Minor 1 Project built under the guidance of Dr. Vivek Tiwari, Built using Flutter, YOLO and TensorflowLite.",
        style: new TextStyle(fontSize: 25.0),
        textAlign: TextAlign.center,
      ),
    ),
   ),
  ],
);
  }
}





