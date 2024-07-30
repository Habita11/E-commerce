
import 'package:flutter/material.dart';

import '../../../../../config/colors.dart';
import '../../../widgets/main_text.dart';

class CellButton extends StatelessWidget {
  final String text;
  final IconData? mainIcon;
  final Color color;
  final String? image;
  final void Function()? onPressed;

  const CellButton({super.key, 
    required this.text,
   this.mainIcon,
    this.onPressed,
    this.image,
    this.color=AppColors.primaryColor

  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        height: 60,
        onPressed: onPressed,
        child: Row(
          children: [
            mainIcon !=null?Icon(
              mainIcon,
              color: color,
            ):SizedBox(
              height: 70,
              width: 50,
              child: Image.asset(image!,
              ),
            ),
            Padding(
              padding:  const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 8),
              child: MainText(
                text: text,
                fontSize: 20,
                color:color,
              ),
            ),
            const Spacer(),
             Icon(
               Icons.arrow_forward_ios ,

              color: color,
              size: 15,
            ),



          ],
        ));
  }
}
