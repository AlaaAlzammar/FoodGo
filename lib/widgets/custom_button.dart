import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_project/globals/app_color.dart';
import 'package:my_project/widgets/customText.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.width,
    this.color,
    this.height,
    this.raduis,
    this.widget,
    this.textColor,
    this.gap,
  });
  final String text;
  final Function()? onTap;
  final double? width;
  final double? height;
  final Color? textColor;
  final Color? color;
  final double? raduis;
  final double? gap;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: color ?? AppColors.primary,
          borderRadius: BorderRadius.circular(raduis ?? 10),
          border: Border.all(color: Colors.white),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Customtext(text: text, color: textColor ?? Colors.white),
            SizedBox(width: gap),
            widget ?? SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
