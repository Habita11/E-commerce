import 'package:flutter/material.dart';

import '../../../../../../config/colors.dart';
import '../../../../../../config/images.dart';
import '../../../../widgets/onboarding.dart';

class SecondOnBoarding extends StatelessWidget {
  const SecondOnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OnBoardingWidget(
        title: "سهولة التسوق",
        text1: "استمتع بتجربة مميزة يمكنك الحصول على كل ما تريد",
        text2: " بسهولة و يسر",
        firstImage: AppImages.wave2,
        secondImage: AppImages.page2);
  }
}
