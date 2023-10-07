import 'package:flutter/material.dart';

defaultSnackBar({required BuildContext context, required String content,required Color color}) {
  ScaffoldMessenger.of(context)
      .removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
      child: Text(content,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: "AppFont",
        ),),
    ),
      backgroundColor: color,

    ),

  );

}
