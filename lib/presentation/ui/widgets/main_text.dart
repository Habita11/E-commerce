import 'package:flutter/material.dart';

class MainText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;

  const MainText({super.key, required this.text, this.fontSize = 20, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style:
            TextStyle(fontSize: fontSize, color: color, fontFamily: "AppFont"));
  }
}
