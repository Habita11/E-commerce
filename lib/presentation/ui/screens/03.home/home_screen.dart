import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matjary/presentation/controller/cubit.dart';
import 'package:matjary/presentation/controller/states.dart';
import 'package:matjary/presentation/ui/screens/03.home/pages/homepage.dart';
import 'package:matjary/presentation/ui/widgets/search_box.dart';

import '../../../../config/colors.dart';
import '../../../../config/images.dart';
import '../../widgets/main_text.dart';

class HomeScreen extends StatelessWidget {

  var globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        AppCubit cubit=AppCubit.get(context);
        return Scaffold(
          extendBody: true,
          backgroundColor: Colors.white,
          bottomNavigationBar: Container(
            margin: EdgeInsets.only(bottom: 10,
            left: 24,right: 24),
            height:70,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.fieldGrey,
                  spreadRadius: 1,
                  blurRadius:1,


                )
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(36)
            ),
            child: Center(
              child: BottomNavigationBar(
                showSelectedLabels: false,
                showUnselectedLabels: false,
                selectedLabelStyle: TextStyle(fontSize: .1),
                unselectedLabelStyle: TextStyle(fontSize: .1),
                backgroundColor: Colors.transparent.withOpacity(0),
                type: BottomNavigationBarType.fixed,
                elevation: 0,
                items: [
                  BottomNavigationBarItem(
                      icon:SizedBox(
                        height: 69,
                        child: Image.asset(
                          cubit.currentIndex==0?AppImages.accountFilled:AppImages.account,
                          scale: 2,),
                      ),
                      label: "الإعدادات"
                  ),
                  BottomNavigationBarItem(
                      icon:(cubit.allProducts.isEmpty || cubit.isCart==true)?Image.asset(cubit.currentIndex==1?
                          AppImages.cartFilled :AppImages.cartBottom,scale: 2):Stack(
                        children: [
                          Positioned(
                            child: Badge(
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              smallSize: 20,
                              label: Text("${cubit.allProducts.length}",style: TextStyle(
                                  color: Colors.white,
                              ),),
                            ),
                            top: 1,
                            right: 0,
                          ),
                          Image.asset(cubit.currentIndex==1?
                          AppImages.cartFilled :AppImages.cartBottom,scale: 2)
                        ],
                      ),
                      label: "السلة"
                  ),
                  BottomNavigationBarItem(
                      icon:Image.asset(cubit.currentIndex==2?AppImages.favoriteFilled:AppImages.favouriteBottom,scale: 2),
                      label: "المفضلة"
                  ),
                  BottomNavigationBarItem(
                      icon:Image.asset(cubit.currentIndex==3?"assets/images/home_icon.png":AppImages.homeOutlined,scale: 2),
                      label: "الرئيسية"
                  ),

                ],
                onTap: (index){
                 cubit.changeNavbar(index);
                 if(index==1){
                   cubit.isCart=true;
                 }
                },
                selectedItemColor: AppColors.primaryColor,
                currentIndex: cubit.currentIndex,
              ),
            ),
          ),
            body:
                NestedScrollView(
                    body: cubit.screens[cubit.currentIndex],
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>cubit.currentIndex!=3?[
                    SliverAppBar(
                      centerTitle: true,
                      backgroundColor: Colors.white,
                      title: Padding(
                        padding: const EdgeInsets.only(top: 30.0,),
                        child: MainText(text:cubit.titles[cubit.currentIndex],color: AppColors.secondaryColor,),
                      ),
                    )
                  ]:[const SliverToBoxAdapter()],
                ),

        );
      },
    );
  }
}
