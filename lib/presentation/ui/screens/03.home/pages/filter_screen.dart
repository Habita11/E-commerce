import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matjary/presentation/ui/widgets/main_button.dart';
import 'package:matjary/presentation/ui/widgets/main_text.dart';
import 'package:matjary/presentation/ui/widgets/text_field.dart';

import '../../../../../config/colors.dart';
import '../../../../../config/images.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../../../controller/cubit.dart';
import '../../../../controller/states.dart';
import '../../../loaders/shimmer/carousel_shimmer.dart';

class FilterScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(builder: (context, state) {
      AppCubit cubit = AppCubit.get(context);
      return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title:  MainText(text:LocaleKeys.filter.tr(),
                color: AppColors.secondaryColor,
              ),
              centerTitle: true,
              leading:IconButton(onPressed: () {
                Navigator.pop(context);
              },
                  icon: const Icon(Icons.arrow_back_outlined,
                    color: AppColors.secondaryColor,)
              ) ,
            ),
            SliverToBoxAdapter(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: DefaultFormField(controller: searchController,
                      hintText: LocaleKeys.searchHome.tr(),
                      suffixIcon: Image.asset(AppImages.search,scale: 3,),
                      label: ""),
                ),
                 Padding(
                  padding: EdgeInsets.only(right: 5,left:5),
                  child: Text(
                    LocaleKeys.categories.tr(),
                    style: const TextStyle(

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
                                    cubit.changeFilterCategoryIndex(index);

                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius
                                            .circular(20),
                                        color: cubit.indexes[index]!
                                            ? AppColors.primaryColor
                                            : Colors.white,
                                        border: Border.all(
                                            color: cubit.indexes[index]!
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
                                            color: cubit.indexes[index]!
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
                                                color: cubit.indexes[index]!
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
                const SizedBox(height: 20,),
               Padding(
                  padding: EdgeInsets.only(right: 10.0,left: 10),
                  child: MainText(text: LocaleKeys.cost.tr(),
                    color: AppColors.secondaryColor,
                    fontSize: 20,

                  ),
                ),
                const SizedBox(height: 20,),
                 Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    MainText(text: "1000 ${cubit.user.currency}",color: AppColors.secondaryColor,),
                    Spacer(),
                    MainText(text: "10000 ${cubit.user.currency}",color: AppColors.secondaryColor,),
                  ],),
                ),
                const SizedBox(height: 10,),
                RangeSlider(
                  divisions: 9,
                  min: 1000,
                  max: 10000,
                  onChanged: (values){
                    cubit.changeRangeValue(values);
                  },
                  values: cubit.rangeValues,
                  labels: RangeLabels(
                    cubit.rangeValues.start.round().toString(),
                    cubit.rangeValues.end.round().toString(),
                  ),

                ),
                 Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 10),
                  child: MainText(text: LocaleKeys.rating.tr(),
                    color: AppColors.secondaryColor,

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 13.0, top: 20,left: 13),
                  child: SizedBox(
                    height: 80,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),

                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          GestureDetector(
                            onTap: () {
                              cubit.changeRatingIndex(index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: index == cubit.ratingTappedIndex
                                      ? AppColors.primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                      color: index == cubit.ratingTappedIndex
                                          ? AppColors.primaryColor
                                          : AppColors.fieldGrey)),
                              width: 80,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      AppImages.starGolden,
                                      color: index == cubit.ratingTappedIndex
                                          ? Colors.white
                                          : null,
                                      scale: 2,
                                    ),
                                    const SizedBox(height: 5,),
                                    Text(
                                      "${index+1}",
                                      style: TextStyle(
                                        color: index== cubit.ratingTappedIndex
                                            ? Colors.white
                                            : AppColors.lightGrey,
                                        fontFamily: "AppFont",
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                      itemCount: 5,
                      separatorBuilder: (context, index) =>
                      const SizedBox(
                        width: 13,
                      ),
                    ),
                  ),
                ),
               const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: MainButton(text:LocaleKeys.search.tr() , onTap:(){
                    Navigator.pushNamed(context, "SearchResultsScreen");
                  }),
                )
              ],
            ),
            )
          ],
        ),
      );
    }, listener: (context, state) {});
  }
}
