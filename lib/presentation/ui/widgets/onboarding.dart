import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/colors.dart';

class OnBoardingWidget extends StatelessWidget {
  String firstImage;
  String secondImage;
  String text1;

  String title;
  OnBoardingWidget({super.key, 
    required this.text1,

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
            top: 120,
            left: 50,
            right: 50,

          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(secondImage,scale: 2,),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 25,
                    color: AppColors.loginColor,
                    fontFamily: "AppFont"),
              ),
              const SizedBox(height: 20,),
              Text(text1,
                  textAlign: TextAlign.center,
                style: const TextStyle(
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
