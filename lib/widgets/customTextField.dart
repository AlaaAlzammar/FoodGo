import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_project/globals/app_color.dart';

class Customtextfield extends StatefulWidget {
  const Customtextfield({
    super.key,
    required this.hint,
    required this.isPassword,
    required this.controller,
  });
  final String hint;
  final bool isPassword;
  final TextEditingController controller;

  @override
  State<Customtextfield> createState() => _CustomtextfieldState();
}

class _CustomtextfieldState extends State<Customtextfield> {
  late bool obscureText;
  @override
  void initState() {
    // TODO: implement initState
    obscureText = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (value) {
        if (value == null) {
          return 'Please fill ${widget.hint}';
        }
        null;
      },
      style: TextStyle(color: Colors.white),
      obscureText: widget.isPassword,
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        fillColor: Colors.white.withOpacity(0.15),
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                child: Icon(CupertinoIcons.eye, color: Colors.white),
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        hintText: widget.hint,
        hintStyle: TextStyle(color: Colors.white),

        filled: true,
      ),
    );
  }
}
