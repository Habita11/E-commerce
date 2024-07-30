import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matjary/config/colors.dart';
import 'package:matjary/presentation/controller/cubit.dart';
import 'package:matjary/config/routes.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:matjary/translations/codegen_loader.g.dart';

void main() async {
  //<item name="android:windowIsTranslucent">true</item>
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      assetLoader: const CodegenLoader(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        theme: ThemeData.light().copyWith(
            colorScheme:
                const ColorScheme.light(primary: AppColors.loginColor)),
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routes: routes,
        initialRoute: "splash",
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
