import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_project/core/services/api_error.dart';
import 'package:my_project/features/auth/data/auth_repo.dart';
import 'package:my_project/globals/app_color.dart';
import 'package:my_project/root.dart';
import 'package:my_project/screens/signupScreen.dart';
import 'package:my_project/widgets/customText.dart';
import 'package:my_project/widgets/customTextField.dart';
import 'package:my_project/widgets/custom_auth_button.dart';
import 'package:my_project/widgets/custom_snackBar.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  final GlobalKey<FormState> frmkey = GlobalKey<FormState>();
  bool isLoading = false;
  AuthRepo authRepo = AuthRepo();
  Future<void> login() async {
    setState(() {
      isLoading = true;
    });
    try {
      final user = await authRepo.login(
        emailCtrl.text.trim(),
        passCtrl.text.trim(),
      );
      if (user != null) {
        Navigator.push(context, MaterialPageRoute(builder: (_) => Root()));
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      String errorMes = 'an error in login';
      if (e is ApiError) {
        errorMes = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(errorMes));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: AppColors.primary,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Form(
                key: frmkey,
                child: Column(
                  children: [
                    SizedBox(height: 100),
                    Image.asset('assets/AppLogo.png', width: 200),
                    SizedBox(height: 10),
                    Customtext(
                      text: 'Welcome Back',
                      color: Colors.white,
                      size: 15,
                      weight: FontWeight.w500,
                    ),
                    SizedBox(height: 70),
                    Customtextfield(
                      hint: 'Email address',
                      isPassword: false,
                      controller: emailCtrl,
                    ),
                    SizedBox(height: 20),
                    Customtextfield(
                      hint: 'Password',
                      isPassword: true,
                      controller: passCtrl,
                    ),
                    SizedBox(height: 30),
                    isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : // Login Button
                          CustomAuthButton(
                            text: 'Login',
                            color: Colors.white,
                            textColor: AppColors.primary,
                            onTap: () {
                              if (frmkey.currentState!.validate()) {
                                login();
                              }
                            },
                            isBordered: false,
                          ),
                    const SizedBox(height: 15),

                    // Signup Button
                    CustomAuthButton(
                      text: 'Create Account',
                      color: Colors.transparent,
                      textColor: Colors.white,
                      isBordered: true,
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const Signupscreen()),
                      ),
                    ),

                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return Root();
                            },
                          ),
                        );
                      },
                      child: Text(
                        'Continue as guest',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
