import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../config/colors.dart';
import '../../../config/images.dart';
import '../../../translations/locale_keys.g.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Image.asset(AppImages.filter,scale: 3,),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 20,right: 10,left: 20,bottom: 20),
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: AppColors.fieldGrey
                )
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(AppImages.search,fit: BoxFit.cover,scale:3,color: AppColors.lightGrey,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3,),
                    child: Text(LocaleKeys.searchHome.tr(),

                      style: const TextStyle(
                          fontFamily: "AppFont",
                          fontSize: 16,

                          color: AppColors.lightGrey
                      ),),
                  ),

                ],
              ),
            ),
          ),
        ),


      ],
    );
  }
}


