import 'package:flutter/material.dart';

import '../../../config/colors.dart';

class ViewWidget extends StatelessWidget {
  String? image;
  Color iconColor;
  Color bgColor;
  bool border;
  double width;
  double height;
  String? text;
  Function()? onTap;
  Color textColor;
  double fontSize;
  double borderRdius;


  ViewWidget({super.key, 
    this.textColor = Colors.white,
    this.image,
     this.iconColor=AppColors.lightGrey,
    required this.bgColor,
    this.border = false,
    this.width = 35,
    this.height = 35,
    this.text,
    required this.onTap,
    this.fontSize=14,
    this.borderRdius=10,

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
            border: border ? Border.all(color: AppColors.fieldGrey) : null,
            borderRadius: BorderRadius.circular(borderRdius),
            color: bgColor,
          ),
          width: width,
          height: height,
          child: text == null
              ? Image.asset(

                  image!,
                  color: iconColor,
                  scale: 3,
                )
              : image == null
                  ? Padding(
                    padding: const EdgeInsets.only(bottom:5.0),
                    child: Center(
                      child: Text(text!,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style:
                              TextStyle(color: textColor, fontFamily: "AppFont",
                              fontSize: fontSize),
                      ),
                    ),
                  )
                  : Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          image!,
                          color: iconColor,
                          scale:2 ,


                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            text!,
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize:fontSize ,
                                color: textColor, fontFamily: "AppFont"),

                          ),
                        ),


                      ],
                    ),
                  )),
    );
  }
}
