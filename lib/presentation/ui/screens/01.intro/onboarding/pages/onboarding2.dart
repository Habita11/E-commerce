import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matjary/translations/locale_keys.g.dart';

import '../../../../../../config/images.dart';
import '../../../../widgets/onboarding.dart';

class SecondOnBoarding extends StatelessWidget {
  const SecondOnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OnBoardingWidget(
        title: LocaleKeys.secondOnboardTitle.tr(),
        text1: LocaleKeys.secondOnboardContent.tr(),
        firstImage: AppImages.wave2,
        secondImage: AppImages.page2);
  }
}
