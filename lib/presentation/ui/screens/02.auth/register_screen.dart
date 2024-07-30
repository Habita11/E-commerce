import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matjary/config/images.dart';
import 'package:matjary/presentation/controller/cubit.dart';
import 'package:matjary/presentation/controller/states.dart';
import 'package:matjary/presentation/ui/popups/snackbar.dart';
import 'package:matjary/presentation/ui/widgets/main_button.dart';
import 'package:matjary/presentation/ui/widgets/text_field.dart';
import 'package:matjary/translations/locale_keys.g.dart';

import '../../../../config/colors.dart';
import '../../widgets/main_text.dart';
import '../../widgets/password_check.dart';

class RegisterScreen extends StatelessWidget {
  bool? isSuccess;
  int counter = 0;
  bool isChecked = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
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
          return Scaffold(
            backgroundColor: AppColors.primaryColor,
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
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 100, bottom: 50),
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
                                LocaleKeys.register.tr(),
                                style: const TextStyle(
                                  fontFamily: "AppFont",
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Container(
                                padding: EdgeInsets.all(width * .05),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      DefaultFormField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              defaultSnackBar(
                                                  context: context,
                                                  content:
                                                  LocaleKeys.userNameValidator
                                                      .tr()
                                                  ,
                                                  color: AppColors.danger);
                                              return "";
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: nameController,
                                          keyboardType: TextInputType.text,
                                          hintText: LocaleKeys.userNameHint
                                              .tr(),
                                          suffixIcon:
                                          const Icon(Icons.person_2_outlined),
                                          label: LocaleKeys.userNameLabel.tr()),
                                      DefaultFormField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              defaultSnackBar(
                                                  context: context,
                                                  content:
                                                  LocaleKeys.emailValidator
                                                      .tr(),
                                                  color: AppColors.danger);
                                              return "";
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: emailController,
                                          keyboardType:
                                          TextInputType.emailAddress,
                                          hintText: LocaleKeys.emailHint.tr(),
                                          suffixIcon:
                                          const Icon(Icons.email_outlined),
                                          label: LocaleKeys.emailLabel.tr()),
                                      DefaultFormField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              defaultSnackBar(
                                                  context: context,
                                                  content:
                                                  LocaleKeys.phoneValidator
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
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                cubit.getCountriesData().then((
                                                    value) {
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
                                                            content:
                                                            Container(
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
                                                                    height:
                                                                    70,
                                                                    width: double
                                                                        .infinity,
                                                                    child: Center(
                                                                        child:
                                                                        MainText(
                                                                            text: LocaleKeys
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
                                                                                cubit
                                                                                    .changeCountry(
                                                                                    cubit
                                                                                        .countries[index]);

                                                                                Navigator
                                                                                    .pop(
                                                                                    context);
                                                                              },
                                                                              child: Padding(
                                                                                padding: const EdgeInsets
                                                                                    .symmetric(
                                                                                    vertical: 10.0,
                                                                                    horizontal: 20),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment
                                                                                      .end,
                                                                                  children: [
                                                                                    Text(
                                                                                        "(+${cubit
                                                                                            .countries[index]
                                                                                            .countryCode})"),
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
                                                                                    CircleAvatar(
                                                                                      radius: 20,
                                                                                      backgroundImage: NetworkImage(
                                                                                          cubit
                                                                                              .countries[index]
                                                                                              .flag),
                                                                                    ),
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
                                                                    height:
                                                                    20,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                  );
                                                });
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Image.network(
                                                    cubit.selectedCountry.flag,
                                                    width: 30,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                      "+${cubit.selectedCountry
                                                          .countryCode}")
                                                ],
                                              ),
                                            ),
                                          ),
                                          suffixIcon: const Icon(
                                              Icons.phone_enabled_outlined),
                                          label: LocaleKeys.phoneLabel.tr()),
                                      DefaultFormField(
                                          onChanged: (value) {
                                            passwordStrength(value);
                                            cubit.changePasswordStrengthText();
                                            switch (counter) {
                                              case 1:
                                                cubit.color4 =
                                                Colors.grey[400]!;
                                                cubit.color3 =
                                                Colors.grey[400]!;
                                                cubit.color2 =
                                                Colors.grey[400]!;
                                                cubit.color = Colors.red;
                                                cubit.passwordStrengthText =
                                                    LocaleKeys.veryWeak.tr();

                                                break;
                                              case 2:
                                                cubit.color4 =
                                                Colors.grey[400]!;
                                                cubit.color3 =
                                                Colors.grey[400]!;
                                                cubit.color2 = Colors.orange;
                                                cubit.color = Colors.orange;
                                                cubit.passwordStrengthText =
                                                    LocaleKeys.weak.tr();

                                                break;
                                              case 3:
                                                cubit.color4 =
                                                Colors.grey[400]!;
                                                cubit.color3 = Colors.yellow;
                                                cubit.color2 = Colors.yellow;
                                                cubit.color = Colors.yellow;
                                                cubit.passwordStrengthText =
                                                    LocaleKeys.Medium.tr();

                                                break;
                                              case 4:
                                                cubit.color4 =
                                                    AppColors.success;
                                                cubit.color3 =
                                                    AppColors.success;
                                                cubit.color2 =
                                                    AppColors.success;
                                                cubit.color = AppColors.success;
                                                cubit.passwordStrengthText =
                                                    LocaleKeys.Strong.tr();

                                                break;
                                              default:
                                                cubit.color4 =
                                                Colors.grey[400]!;
                                                cubit.color3 =
                                                Colors.grey[400]!;
                                                cubit.color2 =
                                                Colors.grey[400]!;
                                                cubit.color = Colors.grey[400]!;
                                                cubit.passwordStrengthText = "";
                                            }
                                          },
                                          keyboardType:
                                          TextInputType.visiblePassword,
                                          obscure: cubit.obscure,
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                value.length < 8) {
                                              defaultSnackBar(
                                                  context: context,
                                                  content:
                                                  LocaleKeys
                                                      .passwordStrengthHint
                                                      .tr(),
                                                  color: AppColors.danger);
                                              return "";
                                            } else if (cubit
                                                .passwordStrengthText !=
                                                LocaleKeys.Strong
                                                    .tr()) {
                                              defaultSnackBar(
                                                  context: context,
                                                  content:
                                                  "  ${LocaleKeys.passwordLabel
                                                      .tr()}+${cubit
                                                      .passwordStrengthText}",
                                                  color: AppColors.danger);
                                              return "";
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: passwordController,
                                          hintText: LocaleKeys.passwordHint
                                              .tr(),
                                          prefixIcon: IconButton(
                                              onPressed: () {
                                                cubit.obscure = !cubit.obscure;
                                                cubit.changeObscureState();
                                              },
                                              icon: cubit.obscure
                                                  ? const Icon(
                                                  Icons.visibility_outlined)
                                                  : const Icon(Icons
                                                  .visibility_off_outlined)),
                                          suffixIcon:
                                          const Icon(
                                              Icons.lock_outline_rounded),
                                          label: LocaleKeys.passwordLabel.tr()),
                                      Row(
                                        children: [
                                          PasswordCheck(color: cubit.color4),
                                          PasswordCheck(color: cubit.color3),
                                          PasswordCheck(color: cubit.color2),
                                          PasswordCheck(color: cubit.color),
                                        ],
                                      ),
                                      Text(
                                        cubit.passwordStrengthText,
                                        style: const TextStyle(
                                            fontFamily: "AppFont",
                                            color: AppColors.info),
                                      ),
                                      DefaultFormField(
                                          validator: (value) {
                                            if (value !=
                                                confirmPasswordController
                                                    .text) {
                                              defaultSnackBar(
                                                  context: context,
                                                  content:
                                                  LocaleKeys
                                                      .confirmPasswordValidator
                                                      .tr(),
                                                  color: AppColors.danger);
                                              return "";
                                            } else {
                                              return null;
                                            }
                                          },
                                          keyboardType:
                                          TextInputType.visiblePassword,
                                          obscure: cubit.obSecureConfirm,
                                          controller: confirmPasswordController,
                                          hintText: LocaleKeys
                                              .ConfirmPasswordHint.tr(),
                                          prefixIcon: IconButton(
                                              onPressed: () {
                                                cubit.obSecureConfirm =
                                                !cubit.obSecureConfirm;
                                                cubit.changeObscureState();
                                              },
                                              icon: cubit.obSecureConfirm
                                                  ? const Icon(
                                                  Icons.visibility_outlined)
                                                  : const Icon(Icons
                                                  .visibility_off_outlined)),
                                          suffixIcon:
                                          const Icon(Icons.lock_clock_outlined),
                                          label: LocaleKeys.ConfirmPasswordLabel
                                              .tr()),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      state is LoadingRegisterState
                                          ? const Center(
                                          child: CircularProgressIndicator())
                                          :

                                      state is SuccessRegisterState ? Center(
                                        child: Image.asset(

                                          AppImages.success,
                                          width: 50,
                                          height: 50,

                                        ),
                                      )
                                          : MainButton(
                                        text: LocaleKeys.confirmRegister.tr(),
                                        onTap: () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            if (isChecked) {
                                              cubit.registerService(
                                                name: nameController.text,
                                                phone: phoneController.text,
                                                password: passwordController
                                                    .text,
                                                confirmPassword:
                                                confirmPasswordController
                                                    .text,
                                                countryCode: cubit
                                                    .selectedCountry
                                                    .countryCode,
                                                countryId: cubit
                                                    .selectedCountry.id
                                                    .toString(),
                                              )
                                                  .then((value) {
                                                Future.delayed(
                                                    const Duration(
                                                        seconds: 2), () {
                                                  Navigator
                                                      .pushReplacementNamed(
                                                      context, "otp",
                                                      arguments: {
                                                        "register": phoneController
                                                            .text
                                                      });
                                                });
                                              }).catchError((e) {
                                                defaultSnackBar(
                                                    context: context,
                                                    content: e.toString(),
                                                    color: Colors.red);
                                              });
                                              cubit.startTimer();
                                            } else {
                                              defaultSnackBar(context: context,
                                                  content: "You should agree to our privacy policy !",
                                                  color: Colors.red);
                                            }
                                          }
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(LocaleKeys.AlreadyHaveAccount
                                              .tr(),
                                              style: const TextStyle(
                                                color: AppColors.secondaryColor,
                                                fontFamily: "AppFont",
                                              )),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                  context, "LoginScreen");
                                              cubit.passwordStrengthText = "";
                                              cubit.color = Colors.grey[400]!;
                                              cubit.color2 = Colors.grey[400]!;
                                              cubit.color3 = Colors.grey[400]!;
                                              cubit.color4 = Colors.grey[400]!;
                                            },
                                            onHover: (_) {},
                                            child:
                                            Text(LocaleKeys.Login.tr(),
                                                style: const TextStyle(
                                                  color: AppColors.primaryColor,
                                                  fontFamily: "AppFont",
                                                )),
                                          ),


                                        ],
                                      ),
                                      Row(mainAxisAlignment: MainAxisAlignment
                                          .start,
                                        children: [
                                          Checkbox(checkColor: AppColors
                                              .primaryColor,

                                              activeColor: Colors.grey,
                                              value: isChecked,
                                              onChanged: (value) {
                                                isChecked = !isChecked;
                                                cubit.changeObscureState();
                                              }),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: GestureDetector(
                                              onTap: () {
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
                                                          content:
                                                          Container(
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
                                                                  height:
                                                                  70,
                                                                  width: double
                                                                      .infinity,
                                                                  child: Center(
                                                                      child:
                                                                      MainText(
                                                                          text: LocaleKeys
                                                                              .privacyPolicy
                                                                              .tr())),
                                                                ),
                                                                const Padding(
                                                                  padding: EdgeInsets
                                                                      .all(8.0),
                                                                  child: MainText(
                                                                    text: "سياسة خصوصية Google‏. عند استخدام خدماتنا، فإنك تأتمننا على معلوماتك. نحن ندرك أن هذه مسؤولية كبيرة ونعمل بجدية لحماية معلوماتك\n "
                                                                        "ونمنحك التحكم فيها."
                                                                    ,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize: 16,
                                                                  ),
                                                                ),


                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                );
                                              },
                                              child: MainText(
                                                text: LocaleKeys.privacyPolicy
                                                    .tr(),
                                                color: AppColors.danger,),
                                            ),
                                          )
                                        ],)
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          );
        },
        listener: (context, state) {});
  }

  passwordStrength(String text) {
    int lower = 0;
    int upper = 0;
    int number = 0;
    int specialChar = 0;
    text.split("").forEach((element) {
      if (int.tryParse(element) != null) {
        number = 1;
      } else if (element == element.toLowerCase() &&
          element == element.toUpperCase()) {
        specialChar = 1;
      } else if (element == element.toUpperCase()) {
        upper = 1;
      } else if (element == element.toLowerCase()) {
        lower = 1;
      }
    });
    counter = specialChar + number + upper + lower;
  }
}
