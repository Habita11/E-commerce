import 'package:flutter/material.dart';

class MainText extends StatelessWidget {
  String text;
  double fontSize;
  Color color;
  MainText({
    required this.text,
    this.fontSize=20,
    this.color=Colors.white
});

  @override
  Widget build(BuildContext context) {
    return Text(

        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        style: TextStyle(
        fontSize:fontSize ,
        color: color, fontFamily: "AppFont")
    );
  }
}
