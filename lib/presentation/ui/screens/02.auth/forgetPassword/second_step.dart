import 'package:flutter/material.dart';

import '../../../../../config/colors.dart';
import '../../../../../config/images.dart';
import '../../../popups/snackbar.dart';
import '../../../widgets/main_button.dart';
import '../../../widgets/text_field.dart';

class SecondStep extends StatefulWidget {
  @override
  State<SecondStep> createState() => _SecondStepState();
}

class _SecondStepState extends State<SecondStep> {
  TextEditingController newPasswordController=TextEditingController();

  TextEditingController confirmNewPasswordController=TextEditingController();

  final formKey=GlobalKey<FormState>();

  bool obscurePassword=true;

  bool obscureConfirm=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppImages.logo,
                  scale: 4,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "استعادة كلمة المرور",
                  style: TextStyle(
                    fontFamily: "AppFont",
                    color: AppColors.primaryColor,
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  "أدخل البريد الالكتروني أو رقم الهاتف",
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: "AppFont",
                    color: Colors.grey[400],
                    fontSize: 16,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0,bottom: 10,left: 20,right: 20),
                  child: DefaultFormField(
                    obscure: obscurePassword,
                      controller: newPasswordController,
                      validator: (value){
                        if(value!.isEmpty){
                          defaultSnackBar(
                              context: context,
                              content: "يجب تعيين كلمة مرور جديدة",
                              color: AppColors.danger);
                          return "";
                        }else{
                          return null;
                        }
                      },
                      suffixIcon: Icon(Icons.lock_outline_rounded),
                      prefixIcon:IconButton(
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                          icon:
                          obscurePassword ? Icon(
                              Icons.visibility_off_outlined) : Icon(
                              Icons.visibility_outlined)
                      ),
                      hintText: "أدخل كلمة المرور الجديدة",
                      label:"تعيين كلمة المرور الجديدة"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,bottom: 20,right: 20,left: 20),
                  child: DefaultFormField(
                    obscure: obscureConfirm,
                      controller: confirmNewPasswordController,
                      validator: (value){
                        if(value!.isEmpty){
                          defaultSnackBar(
                              context: context,
                              content: "يجب تأكيد كلمة المرور الجديدة",
                              color: AppColors.danger);
                          return "";
                        }else if(value != newPasswordController.text){
                          defaultSnackBar(
                              context: context,
                              content: "كلمة المرور غير مطابقة",
                              color: AppColors.danger);
                          return "";
                        }
                        else{
                          return null;
                        }
                      },
                      suffixIcon: Icon(Icons.lock_clock_outlined),
                      prefixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureConfirm = !obscureConfirm;
                            });
                          },
                          icon:
                          obscureConfirm ? Icon(
                              Icons.visibility_off_outlined) : Icon(
                              Icons.visibility_outlined)
                      ),
                      hintText: "تأكيد كلمة المرور الجديدة",
                      label:"تأكيد كلمة المرور الجديدة"),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: MainButton(
                      width: 200,
                      text: "متابعة", onTap: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.pushReplacementNamed(context, "LoginScreen");
                    } else {

                    }
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
