import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:my_project/widgets/customText.dart';

SnackBar customSnackBar(errorMes) {
  return SnackBar(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.only(right: 20, left: 20, bottom: 30),
    elevation: 10,
    behavior: SnackBarBehavior.floating,
    clipBehavior: Clip.none,
    backgroundColor: Colors.red.shade900,
    content: Row(
      children: [
        Icon(CupertinoIcons.info, color: Colors.white),
        SizedBox(width: 14),
        Customtext(
          text: errorMes,
          color: Colors.white,
          size: 14,
          weight: FontWeight.w900,
        ),
      ],
    ),
  );
}
