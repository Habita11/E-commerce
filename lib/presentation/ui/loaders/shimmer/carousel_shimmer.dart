import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../config/colors.dart';

class CarouselShimmer extends StatelessWidget {
  const CarouselShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Shimmer.fromColors(
        direction: ShimmerDirection.ltr,
        period: Duration(milliseconds: 1000),
        baseColor: AppColors.lightGrey.withOpacity(.3),
        highlightColor: AppColors.lightGrey.withOpacity(.1),
        enabled: true,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ListView.separated(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index)=>Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color:Colors.grey ,
                  borderRadius: BorderRadius.circular(15),

                ),
                width: double.infinity,
                height: 130,
              ),
              separatorBuilder: (context,index)=>SizedBox(height: 10,),
              itemCount: 5),
        ),
      ),
    );
  }
}
