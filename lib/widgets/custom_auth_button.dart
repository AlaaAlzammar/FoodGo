import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({
    super.key,
    required this.text,
    required this.color,
    required this.textColor,
    required this.onTap,
    required this.isBordered,
  });
  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;
  final bool isBordered;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          border: isBordered ? Border.all(color: Colors.white, width: 2) : null,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
    ;
  }
}
