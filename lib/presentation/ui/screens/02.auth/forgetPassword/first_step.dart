import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matjary/presentation/controller/cubit.dart';
import 'package:matjary/presentation/ui/widgets/text_field.dart';

import '../../../../../config/colors.dart';
import '../../../../../config/images.dart';
import '../../../../controller/states.dart';
import '../../../popups/snackbar.dart';
import '../../../widgets/main_button.dart';

class FirstStep extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  TextEditingController controller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(builder: (context,state){
      AppCubit cubit=AppCubit.get(context);
      return Scaffold(
        body: Form(
          key: formKey,
          child: Center(
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
                  padding: const EdgeInsets.all(20.0),
                  child: DefaultFormField(controller: controller,
                      validator: (value){
                        if(value!.isEmpty){
                          return "";
                        }else{
                          return null;
                        }
                      },
                      suffixIcon: Icon(Icons.person_2_rounded),
                      hintText: "أدخل البريد الإلكتروني أو رقم الهاتف",
                      label: ""),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: MainButton(
                      width: 200,
                      text: "متابعة", onTap: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.pushReplacementNamed(context, "otp",
                          arguments: {"forget":controller.text});
                      cubit.startTimer();
                    } else {
                      defaultSnackBar(
                          context: context,
                          content: "يجب إدخال البرييد الإلكتروني أو رقم الهاتف",
                          color: AppColors.danger);
                    }

                  }

                  ),
                )
              ],
            ),
          ),
        ),
      );
    }, listener: (context,state){});
  }
}
