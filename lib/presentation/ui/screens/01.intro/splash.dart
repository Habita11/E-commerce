import 'package:flutter/material.dart';

import '../../../../config/images.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHomeScreen();
  }

  Future<void> navigateToHomeScreen() async {
    await Future.delayed(Duration(seconds: 2)); // Simulating a delay of 3 seconds

    Navigator.pushReplacementNamed(context, 'OnBoarding');
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