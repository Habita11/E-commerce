import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matjary/config/colors.dart';
import 'package:matjary/presentation/controller/cubit.dart';
import 'package:matjary/presentation/ui/loaders/shimmer/grid_shimmer.dart';
import 'package:matjary/presentation/ui/screens/01.intro/onboarding/onboarding.dart';
import 'package:matjary/config/routes.dart';
import 'package:matjary/presentation/ui/screens/03.home/home_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
void main() {
  //<item name="android:windowIsTranslucent">true</item>
  WidgetsFlutterBinding.ensureInitialized();
   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>AppCubit(),
      child: MaterialApp(
        theme: ThemeData.light().copyWith(colorScheme:const ColorScheme.light(primary: AppColors.loginColor)),
        routes: routes,
        initialRoute:"splash" ,

        debugShowCheckedModeBanner: false,
      ),
    );
  }
}


