import 'package:flutter/material.dart';

import '../../../config/colors.dart';

class PasswordCheck extends StatelessWidget {
  var color;
  PasswordCheck({
    this.color=AppColors.lightGrey
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(

          width: double.infinity,
          height: 3,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2.5)
          ),
        ),
      ),
    );
  }
}