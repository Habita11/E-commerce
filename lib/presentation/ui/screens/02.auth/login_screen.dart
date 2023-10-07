import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matjary/config/images.dart';
import 'package:matjary/presentation/ui/popups/snackbar.dart';
import 'package:matjary/presentation/ui/screens/02.auth/register_screen.dart';
import 'package:matjary/presentation/ui/widgets/main_button.dart';
import 'package:matjary/presentation/ui/widgets/text_field.dart';

import '../../../../config/colors.dart';
import '../../widgets/button.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool checkValue = false;
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
                  physics: BouncingScrollPhysics(),
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
                        "تسجيل الدخول",
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
                        height: height * .45,
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
                                  focusNode: emailFocusNode,
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  keyboardType: TextInputType.emailAddress,
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
                                  hintText: "أدخل البريد الإلكتروني",
                                  suffixIcon: Icon(Icons.email_outlined),
                                  label: "البريد الإلكتروني"),
                              SizedBox(
                                height: 10,
                              ),
                              DefaultFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      defaultSnackBar(
                                          context: context,
                                          content:
                                              "كلمة المرور لا يمكن أن تكون فارغة",
                                          color: AppColors.danger);
                                      return "";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: passwordController,
                                  hintText: "أدخل كلمة المرور",
                                  obscure: obscure,
                                  prefixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          obscure = !obscure;
                                        });
                                      },
                                      icon: obscure
                                          ? Icon(Icons.visibility_off_outlined)
                                          : Icon(Icons.visibility_outlined)),
                                  suffixIcon:
                                      const Icon(Icons.lock_open_rounded),
                                  label: "كلمة المرور"),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 25.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, "FirstStep");
                                    },
                                    child: const Text("نسيت كلمة المرور؟",
                                        style: TextStyle(
                                            fontFamily: "AppFont",
                                            color: AppColors.primaryColor)),
                                  ),
                                ),
                              ),
                              MainButton(
                                text: "تسجيل الدخول",
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    Navigator.pushNamed(context, "HomeScreen");
                                  } else {}
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    child: const Text("تسجيل حساب جديد",
                                        style: TextStyle(
                                            fontFamily: "AppFont",
                                            color: AppColors.loginColor)),
                                    onTap: () {
                                      Navigator.pushReplacementNamed(
                                          context, "RegisterScreen");
                                    },
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("ليس لديك حساب؟",
                                      style: TextStyle(
                                          fontFamily: "AppFont",
                                          color: AppColors.secondaryColor)),
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
  }
}
