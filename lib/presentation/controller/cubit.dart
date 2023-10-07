import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matjary/domain/entities/product.dart';
import 'package:matjary/presentation/controller/states.dart';

import '../../data/data_source.dart';
import '../../domain/entities/category.dart';
import '../ui/screens/03.home/pages/homepage.dart';
import '../ui/screens/03.home/cart_screen.dart';
import '../ui/screens/03.home/favorites_screen.dart';
import '../ui/screens/03.home/profile/prodile.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  //Create instance of cart
  Cart appCart = Cart();
  Map<Product, int> allProducts = {};

  //otp
  Timer? _timer;
  int start = 60;

  int startTimer(){
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          timer.cancel();
          emit(AppChangeTimerState());
        } else {
          start--;
         emit(AppChangeTimerState());
        }

      },
    );
    return start;
  }

  //bottomnavbar
  int currentIndex = 3;
  bool isCart = false;
  List<Widget> screens = [
    ProfileScreen(),
    CartScreen(),
    FavoritesScreen(),
    HomePage(),
  ];
  List<String> titles = [
    "الملف الشخصي",
    "السلة",
    "المفضلة",
  ];

  //change grid or list view
  bool isGrid = true;

  void changeView() {
    isGrid = false;
    emit(AppChangeViewState());
  }

  void changeListView() {
    isGrid = true;
    emit(AppChangeViewState());
  }

  //change slider value
  RangeValues rangeValues=RangeValues(2000, 8000);
  void changeRangeValue(values){
       rangeValues=values;
       emit(AppChangeSliderState());
  }

//change category
  int tappedIndex = 0;
  int ratingTappedIndex=0;

  void changeCategoryIndex(int index) {
    tappedIndex = index;
    emit(AppChangeCategoryState());
  }
  void changeRatingIndex(int index) {
    ratingTappedIndex = index;
    emit(AppChangeRatingState());
  }

  bool isSelected = false;

  void changeNavbar(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavbarState());
  }

//cart
  void getAllProducts() {
    allProducts = appCart.getProducts();
    emit(AppChangeCartState());
  }

  void clearCart() {
    appCart.emptyCart();
    emit(AppChangeCartState());
  }

  double getTotal() {
    emit(AppChangeCartState());
    return appCart.getTotal();
  }
  //categories data
  List<Categories> categories=[];
  Future<List<Categories>> getCategoriesData()async{
    emit(LoadingCategoriesState());
   categories=await getCategories();
    emit(SuccessCategoriesState());
    return categories;
  }
}
