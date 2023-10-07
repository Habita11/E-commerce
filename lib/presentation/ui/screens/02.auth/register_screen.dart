import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matjary/config/images.dart';
import 'package:matjary/data/data_source.dart';
import 'package:matjary/presentation/controller/cubit.dart';
import 'package:matjary/presentation/controller/states.dart';
import 'package:matjary/presentation/ui/popups/snackbar.dart';
import 'package:matjary/presentation/ui/widgets/button.dart';
import 'package:matjary/presentation/ui/widgets/main_button.dart';
import 'package:matjary/presentation/ui/widgets/text_field.dart';
import 'package:matjary/presentation/ui/screens/02.auth/login_screen.dart';

import '../../../../config/colors.dart';
import '../../widgets/main_text.dart';
import '../../widgets/password_check.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int counter = 0;
  String text = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  bool obSecureConfirm = true;
  var color = Colors.grey[400]!;
  var color2 = Colors.grey[400]!;
  var color3 = Colors.grey[400]!;
  var color4 = Colors.grey[400]!;
  var formKey = GlobalKey<FormState>();
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
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
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.only(
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
                              const Text(
                                "تسجيل حساب جديد",
                                style: TextStyle(
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
                                                      "اسم المستخم لا يمكن أن يكون فارغا",
                                                  color: AppColors.danger);
                                              return "";
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: nameController,
                                          keyboardType: TextInputType.text,
                                          hintText: "أدخل اسم المستخدم",
                                          suffixIcon:
                                              Icon(Icons.person_2_outlined),
                                          label: "اسم المستخدم"),
                                      DefaultFormField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              defaultSnackBar(
                                                  context: context,
                                                  content:
                                                      "البريد الإلكتروني لا يمكن أن يكون فارغا",
                                                  color: AppColors.danger);
                                              return "";
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: emailController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          hintText: "أدخل البريد الإلكتروني",
                                          suffixIcon:
                                              Icon(Icons.email_outlined),
                                          label: "البريد الإلكتروني"),
                                      DefaultFormField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              defaultSnackBar(
                                                  context: context,
                                                  content:
                                                      "رقم الهاتف لا يمكن أن يكون فارغا",
                                                  color: AppColors.danger);
                                              return "";
                                            } else {
                                              return null;
                                            }
                                          },
                                          keyboardType: TextInputType.phone,
                                          controller: phoneController,
                                          hintText: "أدخل رقم الجوال",
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.all(10.0),
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
                                                                  EdgeInsets
                                                                      .all(0),
                                                              content:
                                                                  Container(
                                                                height: 400,
                                                                width: 500,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30)),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: AppColors
                                                                            .primaryColor,
                                                                        borderRadius:
                                                                            BorderRadius.only(
                                                                          topRight:
                                                                              Radius.circular(30),
                                                                          topLeft:
                                                                              Radius.circular(30),
                                                                        ),
                                                                      ),
                                                                      height:
                                                                          70,
                                                                      width: double
                                                                          .infinity,
                                                                      child: Center(
                                                                          child:
                                                                              MainText(text: "اختر دولتك")),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              20.0),
                                                                      child: DefaultFormField(
                                                                          controller: countryController,
                                                                          suffixIcon: Image.asset(
                                                                            AppImages.search,
                                                                            scale:
                                                                                2,
                                                                          ),
                                                                          hintText: "ابحث عن دولتك",
                                                                          label: ""),
                                                                    ),
                                                                    Expanded(
                                                                      child: ListView.separated(
                                                                          itemBuilder: (context, index) => Padding(
                                                                                padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                  children: [
                                                                                    Text("(+20)"),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                                                                      child: MainText(text: "مصر",color: AppColors.secondaryColor,),
                                                                                    ),
                                                                                    CircleAvatar(
                                                                                      radius: 20,
                                                                                      backgroundImage: AssetImage("assets/images/flag.png"),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                          separatorBuilder: (context, index) => Divider(),
                                                                          itemCount: 5),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ));
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Image.asset(
                                                    "assets/images/flag.png",
                                                    width: 30,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text("+20")
                                                ],
                                              ),
                                            ),
                                          ),
                                          suffixIcon: Icon(
                                              Icons.phone_enabled_outlined),
                                          label: "الجوال"),
                                      DefaultFormField(
                                          onChanged: (value) {
                                            passwordStrength(value);
                                            switch (counter) {
                                              case 1:
                                                setState(() {
                                                  color4 = Colors.grey[400]!;
                                                  color3 = Colors.grey[400]!;
                                                  color2 = Colors.grey[400]!;
                                                  color = Colors.red;
                                                  text = "ضعيفة جدا";
                                                });
                                                break;
                                              case 2:
                                                setState(() {
                                                  color4 = Colors.grey[400]!;
                                                  color3 = Colors.grey[400]!;
                                                  color2 = Colors.orange;
                                                  color = Colors.orange;
                                                  text = "ضعيفة";
                                                });
                                                break;
                                              case 3:
                                                setState(() {
                                                  color4 = Colors.grey[400]!;
                                                  color3 = Colors.yellow;
                                                  color2 = Colors.yellow;
                                                  color = Colors.yellow;
                                                  text = "متوسطة";
                                                });
                                                break;
                                              case 4:
                                                setState(() {
                                                  color4 = AppColors.success;
                                                  color3 = AppColors.success;
                                                  color2 = AppColors.success;
                                                  color = AppColors.success;
                                                  text = "قوية";
                                                });
                                                break;
                                              default:
                                                setState(() {
                                                  color4 = Colors.grey[400]!;
                                                  color3 = Colors.grey[400]!;
                                                  color2 = Colors.grey[400]!;
                                                  color = Colors.grey[400]!;
                                                  text = "";
                                                });
                                            }
                                          },
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          obscure: obscure,
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                value.length < 8) {
                                              defaultSnackBar(
                                                  context: context,
                                                  content:
                                                      "كلمة المرور يجب ألا تقل عن ثمان حروف أو علامات",
                                                  color: AppColors.danger);
                                              return "";
                                            } else if (text != "قوية") {
                                              defaultSnackBar(
                                                  context: context,
                                                  content: "  كلمة المرور$text",
                                                  color: AppColors.danger);
                                              return "";
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: passwordController,
                                          hintText: "أدخل كلمة المرور",
                                          prefixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  obscure = !obscure;
                                                });
                                              },
                                              icon: obscure
                                                  ? Icon(
                                                      Icons.visibility_outlined)
                                                  : Icon(Icons
                                                      .visibility_off_outlined)),
                                          suffixIcon:
                                              Icon(Icons.lock_outline_rounded),
                                          label: "كلمة المرور"),
                                      Row(
                                        children: [
                                          PasswordCheck(color: color4),
                                          PasswordCheck(color: color3),
                                          PasswordCheck(color: color2),
                                          PasswordCheck(color: color),
                                        ],
                                      ),
                                      Text(
                                        text,
                                        style: TextStyle(
                                            fontFamily: "AppFont",
                                            color: AppColors.info),
                                      ),
                                      DefaultFormField(
                                          validator: (value) {
                                            if (value !=
                                                passwordController.text) {
                                              defaultSnackBar(
                                                  context: context,
                                                  content:
                                                      "كلمة المرور غير مطابقة",
                                                  color: AppColors.danger);
                                              return "";
                                            } else {
                                              return null;
                                            }
                                          },
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          obscure: obSecureConfirm,
                                          controller: confirmPasswordController,
                                          hintText: "أعد كتابة كلمة المرور",
                                          prefixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  obSecureConfirm =
                                                      !obSecureConfirm;
                                                });
                                              },
                                              icon: obSecureConfirm
                                                  ? Icon(
                                                      Icons.visibility_outlined)
                                                  : Icon(Icons
                                                      .visibility_off_outlined)),
                                          suffixIcon:
                                              Icon(Icons.lock_clock_outlined),
                                          label: "تأكيد كلمة المرور"),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      MainButton(
                                        text: "تسجيل الحساب",
                                        onTap: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            Navigator.pushReplacementNamed(
                                                context, "otp", arguments: {
                                              "register": phoneController.text
                                            });
                                            cubit.startTimer();
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                  context, "LoginScreen");
                                            },
                                            onHover: (_) {},
                                            child: Text("تسجيل الدخول",
                                                style: TextStyle(
                                                  color: AppColors.primaryColor,
                                                  fontFamily: "AppFont",
                                                )),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text("لديك حساب بالفعل؟",
                                              style: TextStyle(
                                                color: AppColors.secondaryColor,
                                                fontFamily: "AppFont",
                                              )),
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
