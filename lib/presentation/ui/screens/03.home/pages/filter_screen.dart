import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matjary/presentation/ui/widgets/main_button.dart';
import 'package:matjary/presentation/ui/widgets/main_text.dart';
import 'package:matjary/presentation/ui/widgets/text_field.dart';

import '../../../../../config/colors.dart';
import '../../../../../config/images.dart';
import '../../../../controller/cubit.dart';
import '../../../../controller/states.dart';

class FilterScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

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
              title: MainText(text: "فلترة المنتجات",
                color: AppColors.secondaryColor,
              ),
              centerTitle: true,
              leadingWidth: 0,
              actions: [IconButton(onPressed: () {
                Navigator.pop(context);
              },
                  icon: const Icon(Icons.arrow_forward_outlined,
                    color: AppColors.secondaryColor,)
              )
              ],
            ),
            SliverToBoxAdapter(child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: DefaultFormField(controller: searchController,
                      hintText: "...ابحث عما تريد",
                      suffixIcon: Image.asset(AppImages.search,scale: 3,),
                      label: ""),
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
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          GestureDetector(
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
                                    Image.asset(
                                      AppImages.smartphone,
                                      color: index == cubit.tappedIndex
                                          ? Colors.white
                                          : AppColors.lightGrey,
                                      scale: 12,
                                    ),
                                    Text(
                                      "موبايلات",
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
                      itemCount: 10,
                      separatorBuilder: (context, index) =>
                      const SizedBox(
                        width: 13,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: MainText(text: "السعر",
                    color: AppColors.secondaryColor,
                    fontSize: 20,

                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    MainText(text: "1000 ر.س",color: AppColors.secondaryColor,),
                    Spacer(),
                    MainText(text: "10000 ر.س",color: AppColors.secondaryColor,),
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
                  padding: const EdgeInsets.only(right: 10.0),
                  child: MainText(text: "التقييم",
                    color: AppColors.secondaryColor,

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 13.0, top: 20),
                  child: SizedBox(
                    height: 80,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      reverse: true,
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
                                    SizedBox(height: 5,),
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
                  child: MainButton(text: "ابحث", onTap:(){
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
