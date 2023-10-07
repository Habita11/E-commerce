import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:matjary/config/images.dart';
import 'package:matjary/presentation/ui/widgets/onboarding.dart';

import '../../../../../../config/colors.dart';

class FirstOnboarding extends StatelessWidget {
  const FirstOnboarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OnBoardingWidget(
        title: "أفضل العروض",
        text1: "تصفح جميع المنتجات المميزة كل ما تحتاج إليه في",
        text2: " مكان واحد بأفضل الأسعار ",
        firstImage: AppImages.wave1,
        secondImage: AppImages.page1);
  }
}
