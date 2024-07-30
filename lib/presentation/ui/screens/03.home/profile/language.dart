import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matjary/presentation/ui/screens/03.home/profile/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeLanguage extends StatelessWidget {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

 ChangeLanguage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Column(
        children: [
          CellButton(onPressed: () async {
            context.setLocale(const Locale("ar"));
            SharedPreferences prefs = await _prefs;
             prefs.setString("lang","ar");
          },
            text: "العربية", image: "assets/images/flag.png",),
          CellButton(
            onPressed: () async {
              context.setLocale(const Locale("en"));
              SharedPreferences prefs = await _prefs;
              prefs.setString("lang","en");
            },
            text: "English", image: "assets/images/british.png",),
        ],
      )
    );
  }
}
