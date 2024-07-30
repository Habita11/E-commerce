import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matjary/presentation/ui/screens/03.home/profile/widgets.dart';
import 'package:matjary/presentation/ui/widgets/main_text.dart';
import 'package:matjary/translations/locale_keys.g.dart';

import '../../../../../config/colors.dart';
import '../../../../../config/images.dart';
import '../../../../../domain/entities/user.dart';
import '../../../../controller/cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppCubit cubit=AppCubit.get(context);
    User user=cubit.user;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(AppImages.account),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  children: [
                    MainText(
                      text: user.name,
                      color: Colors.black,
                      fontSize: 23,
                    ),
                    MainText(
                        text: "+20${user.phone}",
                        color: AppColors.primaryColor,
                        fontSize: 14),
                  ],
                ),
              ),
              const Spacer(),
           IconButton(
                icon:const Icon(Icons.edit,color: AppColors.primaryColor,),
                onPressed: (){},
              ),

            ],
          ),
          Container(
            height: 186,
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[300]!,
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0,2))
                ]),
            child: Center(
              child: Column(
                children: [
                  CellButton(text: LocaleKeys.orders.tr(), mainIcon: Icons.propane_tank_outlined),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Divider(
                      height: 3,
                      thickness: 2,
                    ),
                  ),
                  CellButton(
                    onPressed: (){
                      Navigator.pushNamed(context, "ChangeLanguage");
                    },
                      text: LocaleKeys.language.tr(),
                      mainIcon: Icons.language_outlined),
               Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Divider(
                      height: 3,
                      thickness: 2,
                      color: Colors.grey[300],
                    ),
                  ),
                  CellButton(text: LocaleKeys.about.tr(), mainIcon: Icons.info_outline),
                ],
              ),
            ),
          ),
          Container(
            height: 60,
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[300]!,
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0,2))
                ]),
            child: Center(
              child: Column(
                children: [
                  CellButton(text: LocaleKeys.signOut.tr(),
                      mainIcon: Icons.exit_to_app,
                  color: AppColors.danger,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
