import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../config/colors.dart';

class GridShimmerLoader extends StatelessWidget {
  const GridShimmerLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Shimmer.fromColors(
        direction: ShimmerDirection.rtl,

          period: const Duration(milliseconds:1000),
            baseColor:AppColors.lightGrey.withOpacity(.3),
            highlightColor: AppColors.lightGrey.withOpacity(.1),
            enabled: true,
            child:  SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GridView.count(
                    childAspectRatio:.4,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  crossAxisSpacing: 10,
                    children: List.generate(5, (index) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white
                      ),

                    )),

                  )


                ],
              ),
            ),

      ),
    );
  }
}
