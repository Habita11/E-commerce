import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matjary/config/images.dart';
import 'package:matjary/presentation/controller/states.dart';
import 'package:matjary/presentation/ui/widgets/main_text.dart';

import '../../../../config/colors.dart';
import '../../../controller/cubit.dart';
import '../../widgets/rating.dart';

class FavoritesScreen extends StatelessWidget {


  FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppCubit cubit=AppCubit.get(context);
    cubit.addProductToFavorites("1");
    cubit.addProductToFavorites("1");
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return cubit.favourites.isEmpty?
          Center(
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
                const SizedBox(
                  height: 20,
                ),
                const MainText(
                  text: "لا يوجد منتجات مفضلة",
                  color: AppColors.lightGrey,
                )
              ],
            ),
          ) : Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverList(delegate: SliverChildListDelegate(
                    List.generate(cubit.favourites.length, (index) =>
                        Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.all(10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[50]
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 100,
                                      height: 100,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Image.network(cubit.favourites[index].image,fit: BoxFit.cover,),
                                      ),),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                         SizedBox(
                                           width:200,
                                           child: MainText(text: cubit.favourites[index].name,
                                            color: AppColors.secondaryColor,
                                            fontSize: 16,
                                                                                   ),
                                         ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5.0,bottom: 5),
                                          child: RatingStars(rating: 4),
                                        ),
                                         MainText(text:  "${(cubit.favourites[index].price * (1 -
                                             cubit.favourites[index].discount * .01))
                                             .toStringAsFixed(0)} ${cubit
                                             .favourites[index].currency}",color: Colors.red,
                                          fontSize: 16,)
                                      ],
                                    ),


                                  ],
                                ),


                              ),
                              Positioned(
                                  top: 10,
                                  right: 10,
                                  child: IconButton(onPressed: (){}, icon:const Icon(Icons.favorite,color: Colors.red,))),

                            ]
                        ),
                    ),
                  ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 75,),)
                ]

            ),
          );
        },
        listener: (context, state) {});
  }
}
