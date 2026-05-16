import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_project/globals/app_color.dart';
import 'package:my_project/widgets/customText.dart';
import 'package:my_project/widgets/custom_user_text.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _add = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    _name.text = 'Alaa Alzammar';
    _email.text = 'alaa.alzammar@gmail.com';
    _add.text = 'Gaza ';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: Colors.white,

        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            Center(
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  border: Border.all(width: 5, color: Colors.white),
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 30),
            CustomUserText(ctrl: _name, label: 'Name'),
            SizedBox(height: 20),
            CustomUserText(ctrl: _email, label: 'Email'),
            SizedBox(height: 20),
            CustomUserText(ctrl: _add, label: 'Address'),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Customtext(text: 'Edit Profile', color: Colors.white),
                    SizedBox(width: 10),
                    Icon(CupertinoIcons.pencil, color: Colors.white),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Customtext(text: 'Logout', color: AppColors.primary),
                    SizedBox(width: 10),
                    Icon(Icons.logout, color: AppColors.primary),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
