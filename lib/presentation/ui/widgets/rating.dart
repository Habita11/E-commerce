import 'package:flutter/material.dart';

import '../../../config/colors.dart';
import '../../../config/images.dart';

class RatingStars extends StatelessWidget {
  int rating;
  RatingStars({super.key, 
    required this.rating
});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:200,
      height: 20,

      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [


          ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index)=> Image.asset(
        AppImages.starGolden,
        scale: 3,
      ),
              itemCount: rating.toInt()),
          ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index)=> Image.asset(
                AppImages.starGrey,
                scale: 3,
              ),
              itemCount: 5-rating.toInt()),
          Text(
            "($rating)",
            style: const TextStyle(
                fontFamily: "AppFont",
                color: AppColors.lightGrey),
          ),

        ],
      ),
    );
  }
}
