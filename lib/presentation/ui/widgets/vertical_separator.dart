import 'package:flutter/material.dart';

import '../../../config/colors.dart';

class VerticalSeparator extends StatelessWidget {
  const VerticalSeparator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: AppColors.fieldGrey,
        width: 2,
        height: 20,
      ),
    );
  }
}
