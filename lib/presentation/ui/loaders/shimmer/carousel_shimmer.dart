import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../config/colors.dart';

class CarouselShimmer extends StatelessWidget {
  const CarouselShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Shimmer.fromColors(
            direction: ShimmerDirection.rtl,
            period: const Duration(milliseconds: 1000),
            baseColor: AppColors.lightGrey.withOpacity(.3),
            highlightColor: AppColors.lightGrey.withOpacity(.1),
            enabled: true,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index)=>Container(
                    decoration: BoxDecoration(
                      color:Colors.grey ,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: 100,
                    height: 100,
                  ),
                  separatorBuilder: (context,index)=>const SizedBox(width: 13,),
                  itemCount: 5),
            ),
          ),
        ),
      ),
    );
  }
}
