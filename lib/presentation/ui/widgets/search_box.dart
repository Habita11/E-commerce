import 'package:flutter/material.dart';

import '../../../config/colors.dart';
import '../../../config/images.dart';

class SearchField extends StatelessWidget {

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
            margin: EdgeInsets.only(top: 20,right: 10,left: 20,bottom: 20),
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.fieldGrey
              )
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 10,bottom: 3),
                    child: Text("ابحث عما تريد...",
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,

                style: TextStyle(
                    fontFamily: "AppFont",
                    fontSize: 16,

                  color: AppColors.lightGrey
                ),),
                  ),
              Image.asset(AppImages.search,fit: BoxFit.cover,scale:3,color: AppColors.lightGrey,)

                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}


