import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/colors.dart';

class OnBoardingWidget extends StatelessWidget {
  String firstImage;
  String secondImage;
  String text1;
  String text2;
  String title;
  OnBoardingWidget({
    required this.text1,
    required this.text2,
    required this.firstImage,
    required this.secondImage,
    required this.title
});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Align(alignment: Alignment.topCenter,
            child: SizedBox(
              width: double.infinity,
                child: SvgPicture.asset(firstImage,fit: BoxFit.cover,
                  clipBehavior: Clip.none,
               )
            )
        ),
        Positioned(
            top: 150,
            left: 50,
            right: 50,
            child: Image.asset(secondImage,scale: 2,)),
        Positioned(
          bottom: 50,
          left: 10,
          right: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    color: AppColors.loginColor,
                    fontFamily: "AppFont"),
              ),
              SizedBox(height: 20,),
              Text(text1,
                style: TextStyle(
                    fontSize: 16,
                    color: AppColors.lightGrey,
                    fontFamily: "AppFont"),),
              Text(text2,
                style: TextStyle(
                    fontSize: 16,
                    color: AppColors.lightGrey,
                    fontFamily: "AppFont"),),
            ],
          ),
        )
      ],
    );
  }
}
