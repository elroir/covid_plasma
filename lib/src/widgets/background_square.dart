import 'package:flutter/material.dart';

class BackgroundSquare extends StatelessWidget {
  final Color color;

  BackgroundSquare({this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: color==null ? Theme.of(context).accentColor : color,
      ),
    );
  }
}
