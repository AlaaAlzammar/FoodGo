import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomUserText extends StatelessWidget {
  const CustomUserText({super.key, required this.ctrl, required this.label});
  final TextEditingController ctrl;
  final String label;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: ctrl,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
