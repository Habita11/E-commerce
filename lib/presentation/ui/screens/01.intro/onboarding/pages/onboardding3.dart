import 'package:flutter/material.dart';

import '../../../../../../config/colors.dart';
import '../../../../../../config/images.dart';
import '../../../../widgets/onboarding.dart';

class ThirdOnboarding extends StatelessWidget {
  const ThirdOnboarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OnBoardingWidget(
        title: "التوصيل السريع",
        text1: "جميع طلباتك تصلك حتى باب المنزل في أسرع وقت",
        text2: " ممكن و بأفضل حالة",
        firstImage: AppImages.wave3,
        secondImage: AppImages.page3);
  }
}
