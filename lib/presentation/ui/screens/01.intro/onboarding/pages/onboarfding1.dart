
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matjary/config/images.dart';
import 'package:matjary/presentation/ui/widgets/onboarding.dart';
import 'package:matjary/translations/locale_keys.g.dart';


class FirstOnboarding extends StatelessWidget {
  const FirstOnboarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OnBoardingWidget(
        title: LocaleKeys.firstOnboardTitle.tr(),
        text1: LocaleKeys.firstOnboardContent.tr(),
        firstImage: AppImages.wave1,
        secondImage: AppImages.page1);
  }
}
