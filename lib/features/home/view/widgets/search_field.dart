import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_project/globals/app_color.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key, this.onChanged, required this.controller});
  final Function(String)? onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(15),
      child: TextField(
        cursorColor: AppColors.primary,
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(CupertinoIcons.search),
          hintText: 'Search ..',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
