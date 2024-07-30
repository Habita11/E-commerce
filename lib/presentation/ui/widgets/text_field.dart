import 'package:flutter/material.dart';

import '../../../config/colors.dart';

class DefaultFormField extends StatelessWidget {
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool obscure;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String label;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;

  const DefaultFormField({
    super.key,
    this.focusNode,
    this.validator,
    required this.controller,
    this.obscure = false,
    required this.hintText,
    this.prefixIcon,
     this.suffixIcon,
    required this.label,
    this.onChanged,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: "AppFont",
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.fieldGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 50,
            width: double.infinity,
            child: TextFormField(
              onEditingComplete: () {
                FocusScope.of(context).nextFocus();
                FocusScope.of(context).unfocus();
              },

              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              focusNode: focusNode,
              keyboardType: keyboardType,
              onChanged: onChanged,
              validator: validator,
              controller: controller,
              obscureText: obscure,
              textAlign: TextAlign.start,
              cursorColor: AppColors.loginColor,
              decoration: InputDecoration(
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppColors.danger),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppColors.danger),
                  ),
                  errorStyle: const TextStyle(fontSize: .5,color: Colors.red),
                  hintText: hintText,
                  hintStyle: TextStyle(
                    fontFamily: "AppFont",
                    color: Colors.grey[400],
                  ),
                  prefixIcon:suffixIcon,
                  prefixIconColor: Colors.grey[400],
                  suffixIcon: prefixIcon,
                  suffixIconColor: Colors.grey[400],
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppColors.loginColor),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
