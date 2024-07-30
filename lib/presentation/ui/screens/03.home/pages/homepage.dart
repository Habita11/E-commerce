import 'package:easy_localization/easy_localization.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matjary/presentation/controller/cubit.dart';
import 'package:matjary/presentation/controller/states.dart';
import 'package:matjary/presentation/ui/loaders/shimmer/carousel_shimmer.dart';
import 'package:matjary/presentation/ui/loaders/shimmer/grid_shimmer.dart';
import 'package:matjary/presentation/ui/widgets/main_text.dart';
import 'package:matjary/presentation/ui/widgets/products_grid_view.dart';
import 'package:matjary/presentation/ui/widgets/products_list_view.dart';

import '../../../../../config/colors.dart';
import '../../../../../config/images.dart';
import '../../../../../domain/entities/user.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../../widgets/search_box.dart';

class HomePage extends StatelessWidget {

  ScrollController scrollController = ScrollController();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    cubit.getCategoriesData();

    cubit.getUser();
    cubit.getProductsData(categoryId: cubit.tappedIndex + 1);
    return BlocConsumer<AppCubit, AppStates>(builder: (context, state) {
      return CustomScrollView(physics: const BouncingScrollPhysics(),
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0, bottom: 20,left:10,right: 10 ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:  const EdgeInsetsDirectional.fromSTEB(10,0,0,0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  MainText(
                                    fontSize: 16,
                                    text: LocaleKeys.welcomeText.tr(),
                                    color: AppColors.lightGrey,
                                  ),
                                  MainText(
                                    fontSize: 20,
                                    text:cubit.user.name,
                                    color: AppColors.secondaryColor,
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Image.asset(
                                AppImages.notification,
                                scale: 3,
                              ),
                            ),


                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        GestureDetector(
                          child: const SearchField(),
                          onTap: () {
                            Navigator.pushNamed(context, "FilterScreen");
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: MainText(
                            text: LocaleKeys.offers.tr(),
                            color: AppColors.secondaryColor,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 160,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          child: CarouselSlider(
                              items: List.generate(
                                  10,
                                      (index) =>
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                              width: 260,
                                              height: 150,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(40)),
                                              child: Image.asset(
                                                AppImages.banner,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      )),
                              options: CarouselOptions(
                                  autoPlay: true,
                                  disableCenter: true,
                                  padEnds: false,
                                  viewportFraction: .7)),
                        ),
                      Padding(
                          padding:const EdgeInsets.only(right: 10.0),
                          child: Text(
                            LocaleKeys.categories.tr(),
                            style:const TextStyle(
                                fontFamily: "AppFont",
                                fontSize: 20,
                                color: AppColors.secondaryColor),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.5),
                          child: SizedBox(
                            height: 100,
                            child: BlocBuilder<AppCubit, AppStates>(
                              builder: (context, state) {
                                if (cubit.categories.isNotEmpty) {
                                  return ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                          onTap: () {
                                            cubit.changeCategoryIndex(index);
                                            cubit.getProductsData(
                                                categoryId: index + 1);
                                            scrollController.animateTo(350,
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                curve: Curves.easeInOut);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(20),
                                                color: index ==
                                                    cubit.tappedIndex
                                                    ? AppColors.primaryColor
                                                    : Colors.white,
                                                border: Border.all(
                                                    color: index ==
                                                        cubit.tappedIndex
                                                        ? AppColors.primaryColor
                                                        : AppColors.fieldGrey)),
                                            width: 100,
                                            child: Center(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Image.network(
                                                    cubit.categories[index]
                                                        .image,
                                                    color: index ==
                                                        cubit.tappedIndex
                                                        ? Colors.white
                                                        : AppColors.lightGrey,
                                                    scale: 12,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .all(5.0),
                                                    child: Text(
                                                      cubit.categories[index]
                                                          .name,
                                                      textAlign: TextAlign
                                                          .center,
                                                      style: TextStyle(
                                                        color: index == cubit
                                                            .tappedIndex
                                                            ? Colors.white
                                                            : AppColors
                                                            .lightGrey,
                                                        fontFamily: "AppFont",
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                    itemCount: cubit.categories.length,
                                    separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      width: 13,
                                    ),
                                  );
                                } else {
                                  return const CarouselShimmer();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      // BlocBuilder<AppCubit,AppStates>(
                      //     builder:(context,state){
                      //       return Container(
                      //         margin: const EdgeInsets.only(left: 10),
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(10),
                      //             border: Border.all(color: AppColors.fieldGrey)),
                      //         width: 100,
                      //         height: 60,
                      //         padding: const EdgeInsets.symmetric(vertical: 10),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //           children: [
                      //             ViewWidget(
                      //                 onTap: () {
                      //                   cubit.changeView();
                      //                 },
                      //                 border: cubit.isGrid,
                      //                 image: AppImages.list,
                      //                 iconColor:
                      //                 cubit.isGrid ? AppColors.lightGrey : Colors.white,
                      //                 bgColor: cubit.isGrid
                      //                     ? Colors.white
                      //                     : AppColors.primaryColor),
                      //             ViewWidget(
                      //                 onTap: () {
                      //                   cubit.changeListView();
                      //                 },
                      //                 border: !cubit.isGrid,
                      //                 image: AppImages.grid,
                      //                 iconColor:
                      //                 cubit.isGrid ? Colors.white : AppColors.lightGrey,
                      //                 bgColor: cubit.isGrid
                      //                     ? AppColors.primaryColor
                      //                     : Colors.white),
                      //           ],
                      //         ),
                      //       );
                      //     } ),

                      const SizedBox(
                        height: 10,
                      ),
                       Padding(
                        padding: const EdgeInsets.only(right: 10.0,left: 10),
                        child: Text(
                          LocaleKeys.products.tr(),
                          style:const TextStyle(
                              fontFamily: "AppFont",
                              fontSize: 20,
                              color: AppColors.secondaryColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            cubit.isGrid ? BlocBuilder<AppCubit, AppStates>(
              builder: (context, state) {
                if (state is FailureProductsState || cubit.products.isEmpty) {
                  return SliverToBoxAdapter(
                      child: Center(
                        child: Image.asset(
                          AppImages.emptyCart,
                          scale: 5,
                        ),
                      ));
                }
                else if (state is LoadingProductsState) {
                  return const SliverToBoxAdapter(child: GridShimmerLoader());
                }
                else {
                  return ProductsGrid(cubit: cubit);
                }
              },
              bloc: cubit,
            ) : ProductsList(cubit: cubit,),


            // SliverToBoxAdapter(
            //     child: GridShimmerLoader())
            // SliverToBoxAdapter(child: ListShimmerLoader(),),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 75,
              ),
            ),
          ]);
    },
        listener: (context, state) {});
  }
}
