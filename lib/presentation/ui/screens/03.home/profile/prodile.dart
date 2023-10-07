import 'package:flutter/material.dart';
import 'package:matjary/presentation/ui/widgets/main_text.dart';

import '../../../../../config/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 60,
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 2),
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(
                color: Colors.grey[200]!,
                blurRadius: 5,
              )],
              borderRadius: BorderRadius.circular(20),
                color: Colors.grey[100]
            ),
            child: MaterialButton(
              onPressed: () {},
              child: Row(children: [
                Icon(Icons.arrow_back_ios,size: 15,color: AppColors.lightGrey,),
                Spacer(),
                MainText(text: "طلباتي",
                  color: AppColors.lightGrey,
                  fontSize: 16,
                ),
                SizedBox(width: 5,),
                Icon(Icons.backpack_outlined,color: AppColors.lightGrey,),
              ],),
            ),

          ),
          Container(
            width: double.infinity,
            height: 60,
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 2),
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(
                color: Colors.grey[200]!,
                blurRadius: 5,
              )],
              borderRadius: BorderRadius.circular(20),
                color: Colors.grey[100]
            ),
            child: MaterialButton(
              onPressed: () {},
              child: Row(children: [
                Icon(Icons.arrow_back_ios,size: 15,color: AppColors.lightGrey,),
                Spacer(),
                MainText(text: "طلباتي",
                  color: AppColors.lightGrey,
                  fontSize: 16,
                ),
                SizedBox(width: 5,),
                Icon(Icons.backpack_outlined,color: AppColors.lightGrey,),
              ],),
            ),

          ),
          Container(
            width: double.infinity,
            height: 60,
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 2),
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(
                color: Colors.grey[200]!,
                blurRadius: 5,
              )],
              borderRadius: BorderRadius.circular(20),
                color: Colors.grey[100]
            ),
            child: MaterialButton(
              onPressed: () {},
              child: Row(children: [
                Icon(Icons.arrow_back_ios,size: 15,color: AppColors.lightGrey,),
                Spacer(),
                MainText(text: "طلباتي",
                  color: AppColors.lightGrey,
                  fontSize: 16,
                ),
                SizedBox(width: 5,),
                Icon(Icons.backpack_outlined,color: AppColors.lightGrey,),
              ],),
            ),

          ),
        ],
      ),
    );
  }
}
