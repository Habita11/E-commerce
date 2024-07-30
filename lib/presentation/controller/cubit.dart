import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matjary/domain/entities/Error.dart';
import 'package:matjary/domain/entities/product.dart';
import 'package:matjary/presentation/controller/states.dart';
import 'package:matjary/translations/locale_keys.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/data_source.dart';
import '../../domain/entities/country.dart';
import '../../domain/entities/user.dart';
import '../ui/screens/03.home/pages/homepage.dart';
import '../ui/screens/03.home/cart_screen.dart';
import '../ui/screens/03.home/favorites_screen.dart';
import '../ui/screens/03.home/profile/profile.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  //Create instance of cart
  Cart appCart = Cart();
  Map<Product, int> allProducts = {};

  //otp
  Timer? _timer;
  int start = 60;

  int startTimer() {
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
  int currentIndex = 0;
  bool isCart = false;
  List<Widget> screens = [
    HomePage(),
    FavoritesScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];
  List<String> titles = [
    LocaleKeys.profile.tr(),
    LocaleKeys.favorite.tr(),
    LocaleKeys.cart.tr(),
    LocaleKeys.profile.tr()
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
  RangeValues rangeValues = const RangeValues(2000, 8000);

  void changeRangeValue(values) {
    rangeValues = values;
    emit(AppChangeSliderState());
  }

//change category
  int tappedIndex = 0;
  int ratingTappedIndex = 0;
  int filterCategoryIndex = 0;

  Map<int, bool> indexes = {};

  void addCategoriesindexes(int numOfIndexes) {
    for (int i = 0; i < numOfIndexes; i++) {
      indexes.addAll({i: false});
    }
  }

  void changeFilterCategoryIndex(int index) {
    filterCategoryIndex = index;

    indexes.update(index, (value) => !indexes[index]!);

    emit(AppChangeCategoryState());
  }

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
  List categories = [];

  getCategoriesData() async {
    categories = [];
    emit(LoadingCategoriesState());
    try {
      categories = await getCategories();
      print(categories);
      addCategoriesindexes(categories.length);
      emit(SuccessCategoriesState());
    } on Exception catch (_) {
      print(_);
      emit(FailureProductsState());
    }
  }

  //Products data
  List<Product> products = [];

  getProductsData({required int categoryId}) async {
    emit(LoadingProductsState());
    try {
      products = await getProducts(categoryId: categoryId);
      emit(SuccessProductsState());
      print(products);
    } on Exception catch (_) {
      print(_);
      emit(FailureProductsState());
    }
  }

  //favorites
  bool isFavorite = false;
  List<Product> favourites = [];

  addProductToFavorites(String productId) async {
    emit(LoadingAddTofavoritesState());
    favourites = await changeFavorites(productId);
          emit(SuccessAddTofavoritesState());

  }

  //register
  bool obSecureConfirm = true;
  var color = Colors.grey[400]!;
  var color2 = Colors.grey[400]!;
  var color3 = Colors.grey[400]!;
  var color4 = Colors.grey[400]!;
  bool obscure = true;
  String passwordStrengthText = "";

  changePasswordStrengthText() {
    emit(ChangePasswordStrengthText());
  }

  registerService({
    required String name,
    required String phone,
    required String password,
    required String confirmPassword,
    required String countryCode,
    required String countryId,
  }) async {
    emit(LoadingRegisterState());
    var user = await register(
            name: name,
            phone: phone,
            password: password,
            confirmPassword: confirmPassword,
            countryCode: countryCode,
            countryId: countryId)
        .catchError((e) {
      emit(ErrorRegisterState());
      throw (e.toString());
    });
    if (user != null) {
      print(user);
      emit(SuccessRegisterState());
    }
  }

  User user = User(
    image: "",
    countryCode: "20",
    currency: "SAR",
    id: 1,
    language: "ar",
    name: "",
    phone: "",
    token: "",
    isVerified: 0,
  );

  Future<User> getUser() async {
    SharedPreferences preferences = await _prefs;
    user = User(
      image: preferences.getString("image")!,
      countryCode: preferences.getString("countryCode")!,
      currency: preferences.getString("currency"),
      id: preferences.getInt("id")!,
      language: preferences.getString("language")!,
      name: preferences.getString("name")!,
      phone: preferences.getString("phone")!,
      token: preferences.getString("token"),
      isVerified: preferences.getInt("isVerified"),
    );
    return user;
  }

  //login
  bool loginObscure = true;

  changeObscureState() {
    emit(ChangeObscure());
  }

  List<Country> countries = [];
  Country selectedCountry = Country(
      id: 3000,
      countryCode: "20",
      countryKey: "eg",
      countryName: "Egypt",
      flag:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_Egypt.svg/220px-Flag_of_Egypt.svg.png");

  getCountriesData() async {
    countries = await getCountries();
    selectedCountry = countries[0];
    emit(CountriesSuccessState());
  }

  void changeCountry(country) {
    selectedCountry = country;
    emit(ChangeCountryState());
  }

  Future<Either<User, ErrorMessage>> loginService(
      {required String phone, required String password}) async {
    Either<User, ErrorMessage> response;
    emit(LoadingLoginState());
    response = await login(phone: phone, password: password);
    if (response.isRight()) emit(ErrorLoginState());

    if (response.isLeft()) emit(SuccessLoginState());
    return response;
  }
}
