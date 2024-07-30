import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matjary/config/images.dart';
import 'package:matjary/domain/entities/Error.dart';
import 'package:matjary/presentation/controller/cubit.dart';
import 'package:matjary/presentation/ui/popups/snackbar.dart';
import 'package:matjary/presentation/ui/widgets/main_button.dart';
import 'package:matjary/presentation/ui/widgets/text_field.dart';
import 'package:matjary/translations/locale_keys.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../config/colors.dart';
import '../../../controller/states.dart';
import '../../widgets/main_text.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void setUserData({
    required int id,
    required String countryCode,
    required String name,
    required String image,
    required String phone,
    required String currency,
    required int isVerified,
    required String language,
    required String? token

  }) async {
    SharedPreferences prefs = await _prefs;
    prefs.setInt("id", id);
    prefs.setInt("isVerified", isVerified);
    prefs.setString("countryCode", countryCode);
    prefs.setString("name", name);
    prefs.setString("image", image);
    prefs.setString("phone", phone);
    prefs.setString("currency", currency);
    prefs.setString("language", language);
    prefs.setString("token", token!);
  }

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;


    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);

          cubit.passwordStrengthText = "";
          cubit.color = Colors.grey[400]!;
          cubit.color2 = Colors.grey[400]!;
          cubit.color3 = Colors.grey[400]!;
          cubit.color4 = Colors.grey[400]!;
          return Scaffold(
              body: Stack(
                children: [
                  SizedBox(
                      width: double.infinity,
                      child: SvgPicture.asset(
                        AppImages.login,
                        fit: BoxFit.cover,
                      )),
                  Form(
                      key: formKey,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppImages.logo,
                                  scale: 4,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Text(
                                  LocaleKeys.Login.tr(),
                                  style: const TextStyle(
                                    fontFamily: "AppFont",
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Container(
                                  padding: EdgeInsets.all(width * .05),
                                  width: double.infinity,
                                  height: height * .55,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        DefaultFormField(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                defaultSnackBar(
                                                    context: context,
                                                    content: LocaleKeys
                                                        .phoneValidator
                                                        .tr(),
                                                    color: AppColors.danger);
                                                return "";
                                              } else {
                                                return null;
                                              }
                                            },
                                            keyboardType: TextInputType.phone,
                                            controller: phoneController,
                                            hintText: LocaleKeys.phoneHint.tr(),
                                            prefixIcon: const Icon(
                                                Icons.phone_enabled_outlined),
                                            suffixIcon:Padding(
                                              padding: const EdgeInsets.all(
                                                  10.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  cubit.getCountriesData();
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (context) =>
                                                          AlertDialog(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    30)),
                                                            contentPadding:
                                                            const EdgeInsets
                                                                .all(0),
                                                            content: Container(
                                                              height: 400,
                                                              width: 500,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      30)),
                                                              child: Column(
                                                                mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                                children: [
                                                                  Container(
                                                                    decoration:
                                                                    const BoxDecoration(
                                                                      color: AppColors
                                                                          .primaryColor,
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                        topRight:
                                                                        Radius
                                                                            .circular(
                                                                            30),
                                                                        topLeft:
                                                                        Radius
                                                                            .circular(
                                                                            30),
                                                                      ),
                                                                    ),
                                                                    height: 70,
                                                                    width: double
                                                                        .infinity,
                                                                    child: Center(
                                                                        child: MainText(
                                                                            text:
                                                                            LocaleKeys
                                                                                .chooseCountry
                                                                                .tr())),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                        20.0),
                                                                    child: DefaultFormField(
                                                                        controller: countryController,
                                                                        suffixIcon: Image
                                                                            .asset(
                                                                          AppImages
                                                                              .search,
                                                                          scale:
                                                                          2,
                                                                        ),
                                                                        hintText: LocaleKeys
                                                                            .searchCountry
                                                                            .tr(),
                                                                        label: ""),
                                                                  ),
                                                                  Expanded(
                                                                    child: ListView
                                                                        .separated(
                                                                        itemBuilder: (
                                                                            context,
                                                                            index) =>
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                Navigator
                                                                                    .pop(
                                                                                    context);
                                                                                cubit
                                                                                    .changeCountry(
                                                                                    cubit
                                                                                        .countries[index]);
                                                                              },
                                                                              child: Padding(
                                                                                padding: const EdgeInsets
                                                                                    .symmetric(
                                                                                    vertical: 10.0,
                                                                                    horizontal: 20),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment
                                                                                      .start,
                                                                                  children: [
                                                                                    CircleAvatar(
                                                                                      radius: 20,
                                                                                      backgroundImage: NetworkImage(
                                                                                          cubit
                                                                                              .countries[index]
                                                                                              .flag),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets
                                                                                          .only(
                                                                                          bottom: 10,
                                                                                          right: 10,
                                                                                          left: 10),
                                                                                      child: MainText(
                                                                                        text: cubit
                                                                                            .countries[index]
                                                                                            .countryName,
                                                                                        color: AppColors
                                                                                            .secondaryColor,
                                                                                      ),
                                                                                    ),
                                                                                    Text(
                                                                                        "(+${cubit
                                                                                            .countries[index]
                                                                                            .countryCode})"),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                        separatorBuilder: (
                                                                            context,
                                                                            index) => const Divider(),
                                                                        itemCount: cubit
                                                                            .countries
                                                                            .length),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ));
                                                },
                                                child: Row(
                                                  mainAxisSize: MainAxisSize
                                                      .min,
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundImage: NetworkImage(
                                                        cubit.selectedCountry!
                                                            .flag,
                                                      ),
                                                      radius: 20,
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                        "+${cubit
                                                            .selectedCountry!
                                                            .countryCode}"
                                                    ,
                                                    style: TextStyle(fontSize: 16),),

                                                  ],
                                                ),
                                              ),
                                            ),
                                            label: LocaleKeys.phoneLabel.tr()),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        DefaultFormField(
                                            keyboardType:
                                            TextInputType.visiblePassword,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                defaultSnackBar(
                                                    context: context,
                                                    content: LocaleKeys
                                                        .passwordValidator
                                                        .tr(),
                                                    color: AppColors.danger);
                                                return "";
                                              } else {
                                                return null;
                                              }
                                            },
                                            controller: passwordController,
                                            hintText: LocaleKeys.passwordHint
                                                .tr(),
                                            obscure: cubit.loginObscure,
                                            prefixIcon: IconButton(
                                                onPressed: () {
                                                  cubit.loginObscure =
                                                  !cubit.loginObscure;
                                                  cubit.changeObscureState();
                                                },
                                                icon: cubit.loginObscure
                                                    ? const Icon(Icons
                                                    .visibility_off_outlined)
                                                    : const Icon(
                                                    Icons.visibility_outlined)),
                                            suffixIcon:
                                            const Icon(Icons.lock_open_rounded),
                                            label: LocaleKeys.passwordLabel
                                                .tr()),
                                        Align(
                                          alignment: AlignmentDirectional
                                              .centerEnd,
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(bottom: 25.0),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context, "FirstStep");
                                              },
                                              child: Text(
                                                  LocaleKeys.forgotPassword
                                                      .tr(),
                                                  style: const TextStyle(
                                                      fontFamily: "AppFont",
                                                      color:
                                                      AppColors.primaryColor)),
                                            ),
                                          ),
                                        ),
                                        state is LoadingLoginState
                                            ? const Center(
                                            child: CircularProgressIndicator())
                                            : state is SuccessLoginState
                                            ? Center(
                                          child: Image.asset(
                                            AppImages.success,
                                            width: 50,
                                            height: 50,
                                          ),
                                        )
                                            : MainButton(
                                          text: LocaleKeys.Login.tr(),
                                          onTap: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              cubit
                                                  .loginService(
                                                  phone:
                                                  phoneController
                                                      .text,
                                                  password:
                                                  passwordController
                                                      .text)
                                                  .then((value) {
                                                value.fold(
                                                        (user)async {
                                                          SharedPreferences prefs = await _prefs;
                                                          prefs.setBool("isLogged", true);
                                                      setUserData(id: user.id,
                                                          countryCode: user.countryCode,
                                                          name: user.name,
                                                          image: user.image,
                                                          phone: user.phone,
                                                          currency: user.currency!,
                                                          isVerified: user.isVerified!,
                                                          language: user.language,
                                                          token: user.token);

                                                      Future.delayed(
                                                          const Duration(
                                                              seconds: 1),
                                                              () {
                                                            Navigator
                                                                .pushReplacementNamed(
                                                                context,
                                                                "HomeScreen");
                                                          });
                                                    },
                                                        (error) =>
                                                        defaultSnackBar(
                                                            context:
                                                            context,
                                                            content:
                                                            error.message,
                                                            color:
                                                            Colors.red));
                                              });
                                            } else {}
                                          },
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                LocaleKeys.dontHaveAccount.tr(),
                                                style: const TextStyle(
                                                    fontFamily: "AppFont",
                                                    color:
                                                    AppColors.secondaryColor)),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            GestureDetector(
                                              child: Text(
                                                  LocaleKeys.createAccount.tr(),
                                                  style: const TextStyle(
                                                      fontFamily: "AppFont",
                                                      color: AppColors
                                                          .loginColor)),
                                              onTap: () {
                                                Navigator.pushReplacementNamed(
                                                    context, "RegisterScreen");
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              ));
        },
        listener: (context, state) {});
  }
}
