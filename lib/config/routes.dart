

import 'package:flutter/material.dart';
import 'package:matjary/presentation/ui/screens/03.home/pages/homepage.dart';
import 'package:matjary/presentation/ui/screens/03.home/pages/product_details.dart';
import 'package:matjary/presentation/ui/screens/03.home/home_screen.dart';
import 'package:matjary/presentation/ui/screens/02.auth/login_screen.dart';
import 'package:matjary/presentation/ui/screens/01.intro/onboarding/onboarding.dart';
import 'package:matjary/presentation/ui/screens/03.home/pages/order_screen.dart';
import 'package:matjary/presentation/ui/screens/02.auth/otp.dart';
import 'package:matjary/presentation/ui/screens/01.intro/splash.dart';
import 'package:matjary/presentation/ui/screens/03.home/pages/search_results_screen.dart';
import '../presentation/ui/screens/03.home/pages/filter_screen.dart';
import '../presentation/ui/screens/02.auth/forgetPassword/first_step.dart';
import '../presentation/ui/screens/02.auth/register_screen.dart';
import '../presentation/ui/screens/02.auth/forgetPassword/second_step.dart';
import '../presentation/ui/screens/03.home/profile/language.dart';

Map<String,Widget Function(BuildContext)> routes={
  "HomeScreen":(context)=>HomeScreen(),
  "HomePage":(context)=>HomePage(),
  "LoginScreen":(context)=>LoginScreen(),
  "RegisterScreen":(context)=>RegisterScreen(),
  "ProductDetails":(context)=>const ProductDetails(),
  "FilterScreen":(context)=>FilterScreen(),
  "OrderScreen":(context)=>OrderScreen(),
  "OnBoarding":(context)=> OnBoardingScreen(),
  "splash":(context)=> SplashScreen(),
  "otp":(context)=>const OTPScreen(),
  "FirstStep":(context)=>FirstStep(),
  "SecondStep":(context)=>const SecondStep(),
  "SearchResults":(context)=>const SearchResultsScreen(),
  "ChangeLanguage":(context)=> ChangeLanguage(),
};