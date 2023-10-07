import 'package:flutter/material.dart';
import 'package:matjary/config/colors.dart';

class MainButton extends StatelessWidget {
  String text;
  void Function()? onTap;
  double width;
  double height;
  double fontSize;
  Color? color;
  Color? textColor;
  MainButton({
    required this.text,
    required this.onTap,
    this.height=50,
     this.width=double.infinity,
    this.fontSize=20,
    this.color=AppColors.primaryColor,
    this.textColor=Colors.white,
});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ,
      child: Container(
          padding: EdgeInsets.only(bottom: 5,),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),

        ),
        width: width,
        height: height,
        child:  Center(
          child: Text(
      text,
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
      style: TextStyle(
      fontSize:fontSize ,
      color:textColor, fontFamily: "AppFont"),
      ),
        )
      ),
    );
  }
}
