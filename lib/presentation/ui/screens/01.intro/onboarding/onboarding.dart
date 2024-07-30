import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matjary/presentation/ui/screens/01.intro/onboarding/pages/onboardding3.dart';
import 'package:matjary/presentation/ui/screens/01.intro/onboarding/pages/onboarding2.dart';
import 'package:matjary/presentation/ui/screens/01.intro/onboarding/pages/onboarfding1.dart';
import 'package:matjary/presentation/ui/widgets/main_button.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../config/colors.dart';
import '../../../../../translations/locale_keys.g.dart';

class OnBoardingScreen extends StatefulWidget {


  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  PageController controller = PageController();

  List<Widget>pages= [
    const FirstOnboarding(),
    const SecondOnBoarding(),
    const ThirdOnboarding()
  ];
  bool isLast=false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            fit: FlexFit.loose,
            flex: 3,
            child: PageView(
              controller: controller,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (index){
                if(index==pages.length-1){
                  setState(() {
                    isLast=true;
                  });
                }else{
                  setState(() {
                    isLast=false;
                  });
                }
              },
              children: pages,

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: MainButton(
              width: 200,
              onTap:() async{
              if(isLast){
                SharedPreferences prefs = await _prefs;
                prefs.setBool("isFirstTime", false);
                Navigator.pushNamed(context, "LoginScreen");


              }else{ controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut);
              }

            },

              text:isLast?LocaleKeys.startNow.tr():LocaleKeys.next.tr(),)
          ),
          SmoothPageIndicator(controller: controller,
              effect: const WormEffect(
                dotHeight: 7,
                dotWidth: 7,
                activeDotColor: AppColors.loginColor

              ),

              count:pages.length ,
            axisDirection: Axis.horizontal,
          ),
        isLast?const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            "",
            style:
            TextStyle(color: AppColors.lightGrey, fontFamily: "AppFont"),
          ),
        ): Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: (){
                controller.jumpToPage(pages.length-1,);
              },
              child: Text(
                LocaleKeys.Skip.tr(),
                style:
                    const TextStyle(color: AppColors.lightGrey, fontFamily: "AppFont"),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
