import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_project/features/auth/data/auth_repo.dart';
import 'package:my_project/globals/app_color.dart';
import 'package:my_project/root.dart';
import 'package:my_project/screens/loginScreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  AuthRepo authRepo = AuthRepo();
  Future<void> _checkLogin() async {
    try {
      if (authRepo.isGuest) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => Root()),
        );
      } else if (authRepo.isLogging) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => Root()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => Loginscreen()),
        );
      }
    } catch (e) {
      e.toString();
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    Future.delayed(const Duration(seconds: 2), _checkLogin);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.0,
            colors: [
              Color(0xFFFF5F6D), // A lighter, "glowing" version of your red
              Color(0xFFEF2B39), // Your exact brand color
              Color(0xFF910A14), // A deeper "shadow" red for the very edges
            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 280),
            Center(child: Image.asset('assets/AppLogo.png', width: 200)),
            Spacer(),
            Stack(
              children: [
                Align(
                  alignment: AlignmentGeometry.center,
                  child: Image.asset('assets/image 1.png'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
