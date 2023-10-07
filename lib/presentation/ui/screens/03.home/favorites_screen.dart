import 'package:flutter/material.dart';
import 'package:matjary/config/images.dart';
import 'package:matjary/presentation/ui/widgets/main_text.dart';

import '../../../../config/colors.dart';
import '../../widgets/rating.dart';

class FavoritesScreen extends StatelessWidget {
 List favorites=[1,2,3];

  @override
  Widget build(BuildContext context) {
    return favorites.isEmpty?Center(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Image.asset(
              AppImages.favoriteIllustration,
              scale: 2,
            )),
            SizedBox(
              height: 20,
            ),
            MainText(
              text: "لا يوجد منتجات مفضلة",
              color: AppColors.lightGrey,
            )
          ],
        ),
    ) : Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverList(delegate: SliverChildListDelegate(
              List.generate(favorites.length, (index) =>
                  Stack(
                    children: [
                      Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[50]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              MainText(text: "اسم المنتج",
                              color: AppColors.secondaryColor,
                                fontSize: 16,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0,bottom: 5),
                                child: RatingStars(rating: 4),
                              ),
                              MainText(text: "900 ر.س",color: Colors.red,
                              fontSize: 16,)
                            ],
                          ),

                          SizedBox(width: 100,
                          height: 100,
                          child: Image.asset(AppImages.iphone,fit: BoxFit.cover,),)
                        ],
                      ),


                    ),
                      Positioned(
                        top: 10,
                          left: 10,
                          child: IconButton(onPressed: (){}, icon:Icon(Icons.favorite,color: Colors.red,))),
                    ]
                  ),
              ),
            ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 75,),)
          ]

      ),
    );
  }
}
