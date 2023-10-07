import 'package:flutter/material.dart';
import 'package:matjary/presentation/ui/screens/01.intro/onboarding/pages/onboardding3.dart';
import 'package:matjary/presentation/ui/screens/01.intro/onboarding/pages/onboarding2.dart';
import 'package:matjary/presentation/ui/screens/01.intro/onboarding/pages/onboarfding1.dart';
import 'package:matjary/presentation/ui/widgets/button.dart';
import 'package:matjary/presentation/ui/widgets/main_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../config/colors.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController controller = PageController();

  List<Widget>pages= [
    FirstOnboarding(),
    SecondOnBoarding(),
    ThirdOnboarding()
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
              children: pages,
              physics: BouncingScrollPhysics(),
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

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: MainButton(
              width: 200,
              onTap:() {
              if(isLast){
                Navigator.pushNamed(context, "LoginScreen");
              }else{ controller.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeOut);
              }

            },

              text:isLast?"ابدأ الأن":"التالي",)
          ),
          SmoothPageIndicator(controller: controller,
              effect: WormEffect(
                dotHeight: 7,
                dotWidth: 7,
                activeDotColor: AppColors.loginColor

              ),

              count:pages.length ,
            axisDirection: Axis.horizontal,
          ),
        isLast?Padding(
          padding: const EdgeInsets.all(20.0),
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
                "تخطي",
                style:
                    TextStyle(color: AppColors.lightGrey, fontFamily: "AppFont"),
              ),
            ),
          ),
          SizedBox(height: 30,)
        ],
      ),
    );
  }
}
