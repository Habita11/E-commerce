import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../config/images.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    navigateToHomeScreen();
  }

  Future<void> navigateToHomeScreen() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulating a delay of 3 seconds
    SharedPreferences prefs = await _prefs;
    bool? isFirstTime=prefs.getBool("isFirstTime");
    bool? isLogged=prefs.getBool("isLogged");

    if(isFirstTime == false ){
      if(isLogged == true){
        Navigator.pushReplacementNamed(context, 'HomeScreen');
      }else{
        Navigator.pushReplacementNamed(context, 'LoginScreen');
      }
    }else if(isFirstTime !=false){
      Navigator.pushReplacementNamed(context, 'OnBoarding');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(width: double.infinity,
          child: Image.asset(AppImages.splash,
          fit: BoxFit.cover,))
    );
  }
}