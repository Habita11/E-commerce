import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../config/colors.dart';

class ListShimmerLoader extends StatelessWidget {
  const ListShimmerLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Shimmer.fromColors(
        direction: ShimmerDirection.ltr,
        period: const Duration(milliseconds: 1000),
        baseColor: AppColors.lightGrey.withOpacity(.3),
        highlightColor: AppColors.lightGrey.withOpacity(.1),
        enabled: true,
        child: SingleChildScrollView(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
              itemBuilder: (context,index)=>Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color:Colors.grey ,
                  borderRadius: BorderRadius.circular(15),

                ),
                width: double.infinity,
                height: 200,
              ),
              separatorBuilder: (context,index)=>const SizedBox(height: 10,),
              itemCount: 5),
        ),
      ),
    );
  }
}
