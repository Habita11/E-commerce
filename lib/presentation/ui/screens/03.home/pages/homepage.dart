import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matjary/presentation/controller/cubit.dart';
import 'package:matjary/presentation/controller/states.dart';
import 'package:matjary/presentation/ui/loaders/shimmer/grid_shimmer.dart';
import 'package:matjary/presentation/ui/loaders/shimmer/list_shimmer.dart';
import 'package:matjary/presentation/ui/widgets/main_text.dart';
import 'package:matjary/presentation/ui/widgets/products_grid_view.dart';
import 'package:matjary/presentation/ui/widgets/products_list_view.dart';

import '../../../../../config/colors.dart';
import '../../../../../config/images.dart';
import '../../../../../domain/entities/category.dart';
import '../../../widgets/button.dart';
import '../../../widgets/search_box.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          cubit.getCategoriesData();
          return  CustomScrollView(
              physics: const BouncingScrollPhysics(), slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0,bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Image.asset(AppImages.notification,scale: 3,),
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                MainText(fontSize: 16,
                                  text:"مرحبا،أهلا بك 👋",color: AppColors.lightGrey,),
                                MainText(fontSize: 20,
                                  text:"محمد حبيته",color: AppColors.secondaryColor,),
                              ],
                            ),
                            const SizedBox(width: 10,),
                          ],
                        ),
                        GestureDetector(
                          child: SearchField(),
                          onTap: () {
                            Navigator.pushNamed(context, "FilterScreen");
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: MainText(text: "العروض",color: AppColors.secondaryColor,),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 160,
                          width: MediaQuery.of(context).size.width,
                          child: CarouselSlider(
                              items: List.generate(
                                  10,
                                      (index) => Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          width: 260,
                                          height: 150,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  40)),
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
                        const Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Text(
                            "الفئات",
                            style: TextStyle(
                                fontFamily: "AppFont",
                                fontSize: 20,
                                color: AppColors.secondaryColor),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 13.0),
                          child: SizedBox(
                            height: 80,
                            child:state==LoadingCategoriesState()?CircularProgressIndicator():State==SuccessCategoriesState()? ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              reverse: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  cubit.changeCategoryIndex(index);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: index == cubit.tappedIndex
                                          ? AppColors.primaryColor
                                          : Colors.white,
                                      border: Border.all(
                                          color: index == cubit.tappedIndex
                                              ? AppColors.primaryColor
                                              : AppColors.fieldGrey)),
                                  width: 80,
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.network(
                                          cubit.categories[index].image,
                                          color: index == cubit.tappedIndex
                                              ? Colors.white
                                              : AppColors.lightGrey,
                                          scale: 12,
                                        ),
                                        Text(
                                          cubit.categories[index].name,
                                          style: TextStyle(
                                              color: index == cubit.tappedIndex
                                                  ? Colors.white
                                                  : AppColors.lightGrey,
                                              fontFamily: "AppFont",
                                              fontSize: 14,
                                              ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              itemCount: cubit.categories.length,
                              separatorBuilder: (context, index) => const SizedBox(
                                width: 13,
                              ),
                            ):CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.fieldGrey)),
                        width: 100,
                        height: 60,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            ViewWidget(
                                onTap: () {
                                  cubit.changeView();
                                },
                                border: cubit.isGrid,
                                image: AppImages.list,
                                iconColor: cubit.isGrid
                                    ? AppColors.lightGrey
                                    : Colors.white,
                                bgColor: cubit.isGrid
                                    ? Colors.white
                                    : AppColors.primaryColor),
                            ViewWidget(
                                onTap: () {
                                  cubit.changeListView();
                                },
                                border: !cubit.isGrid,
                                image: AppImages.grid,
                                iconColor: cubit.isGrid
                                    ? Colors.white
                                    : AppColors.lightGrey,
                                bgColor: cubit.isGrid
                                    ? AppColors.primaryColor
                                    : Colors.white),
                          ],
                        ),
                      ),
                      const Spacer(),
                     const Padding(
                       padding:  EdgeInsets.only(right: 10.0),
                       child:  Text(
                          "المنتجات",
                          style: TextStyle(
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
            cubit.isGrid ? ProductsGrid(cubit: cubit,) : ProductsList(cubit: cubit,),
            // SliverToBoxAdapter(
            //     child: GridShimmerLoader())
            // SliverToBoxAdapter(child: ListShimmerLoader(),),
            const SliverToBoxAdapter(child: SizedBox(height: 75,),)
          ]);
        },
        listener: (context, state) {});
  }
}
