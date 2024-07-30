import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matjary/translations/locale_keys.g.dart';
import '../../../../../../config/images.dart';
import '../../../../widgets/onboarding.dart';

class ThirdOnboarding extends StatelessWidget {
  const ThirdOnboarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OnBoardingWidget(
        title: LocaleKeys.thirdOnboardTitle.tr(),
        text1: LocaleKeys.thirdOnboardContent.tr(),
        firstImage: AppImages.wave3,
        secondImage: AppImages.page3);
  }
}
