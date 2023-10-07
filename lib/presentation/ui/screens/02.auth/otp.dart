import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matjary/presentation/controller/cubit.dart';
import 'package:matjary/presentation/controller/states.dart';
import 'package:matjary/presentation/ui/popups/snackbar.dart';
import 'package:matjary/presentation/ui/widgets/main_button.dart';
import 'package:matjary/presentation/ui/widgets/main_text.dart';
import 'package:pinput/pinput.dart';

import '../../../../config/colors.dart';
import '../../../../config/images.dart';

class OTPScreen extends StatefulWidget {

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final timer=Timer(Duration(seconds: 40), (){ },
  );

  final defaultPinTheme = PinTheme(
    width: 60,
    height: 60,
    textStyle: TextStyle(fontSize: 20,
        color: AppColors.primaryColor,
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: AppColors.fieldGrey,
      borderRadius: BorderRadius.circular(10),
    ),
  );

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
        builder: (context,state){
      final userData=ModalRoute.of(context)!.settings.arguments as Map;
      AppCubit cubit=AppCubit.get(context);
      return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
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
                "تأكيد رمز التحقق",
                style: TextStyle(
                  fontFamily: "AppFont",
                  color: AppColors.primaryColor,
                  fontSize: 25,
                ),
              ),
              SizedBox(height: 10,),
              Text(
                "تم إرسال رمز التحقق على ${userData.values.first}",
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: "AppFont",
                  color:Colors.grey[400],
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20),
              Pinput(
                controller: otpController,
                errorTextStyle: TextStyle(fontSize: .1),
                errorPinTheme: defaultPinTheme.copyWith(
                    decoration: BoxDecoration(
                        color: AppColors.fieldGrey,
                        border: Border.all(color: AppColors.danger),
                        borderRadius: BorderRadius.circular(10)
                    )
                ),
                validator: (value) {
                  if (value != "1564") {
                    return "Invalid OTP";
                  } else {
                    return null;
                  }
                },
                pinputAutovalidateMode: PinputAutovalidateMode.disabled,
                autofocus: true,
                smsCodeMatcher: "1564",
                listenForMultipleSmsOnAndroid: true,
                androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
                separatorBuilder: (_) => SizedBox(width: 20,),
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: BoxDecoration(
                        color: AppColors.fieldGrey,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.primaryColor)
                    )
                ),

              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0,bottom: 10,left: 10,right: 10),
                child: MainButton(text: "تأكيد رمز التحقق", onTap: () {
                  if (formKey.currentState!.validate()) {
                    if(userData.keys.first=="register")
                    { Navigator.pushReplacementNamed(context, "HomeScreen");}
                    else if(userData.keys.first=="forget"){
                      Navigator.pushReplacementNamed(context,"SecondStep");
                    }

                  } else {
                    defaultSnackBar(
                        context: context,
                        content: "رمز التحقق غير صحيح",
                        color: AppColors.danger);
                  }
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MainText(text:cubit.start!=0? "إعادة الإرسال (${cubit.start } ث)":"إعادة الإرسال",fontSize: 16,color: cubit.start!=0?AppColors.lightGrey:AppColors.primaryColor,),
                    SizedBox(width: 5,),
                    MainText(text: "لم يصلك الرمز؟",color: Colors.grey[400]!,fontSize: 16),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );},
        listener: (context,index){}
    );
  }
}
