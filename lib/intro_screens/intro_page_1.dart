import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
     color: Colors.pink[100],
      child: Center(
          child: Column(
            children: [
              Text('Página 1'),
              //put images and cool stuff here
            ],
          )
      ),
    );
  }
}