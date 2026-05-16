import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_project/core/services/api_error.dart';
import 'package:my_project/features/auth/data/auth_repo.dart';
import 'package:my_project/globals/app_color.dart';
import 'package:my_project/root.dart';
import 'package:my_project/screens/loginScreen.dart';
import 'package:my_project/widgets/customText.dart';
import 'package:my_project/widgets/customTextField.dart';
import 'package:my_project/widgets/custom_auth_button.dart';
import 'package:my_project/widgets/custom_snackBar.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  final GlobalKey<FormState> frmkey = GlobalKey<FormState>();
  AuthRepo authrepo = AuthRepo();
  bool isLoading = false;
  Future<void> signup() async {
    if (frmkey.currentState!.validate()) {
      try {
        setState(() {
          isLoading = true;
        });
        final user = await authrepo.signup(
          nameCtrl.text.trim(),
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
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameCtrl.dispose();
    emailCtrl.dispose();
    passCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: frmkey,
              child: Column(
                children: [
                  SizedBox(height: 100),
                  Image.asset(
                    'assets/AppLogo.png',
                    width: 200,
                    color: AppColors.primary,
                  ),
                  Customtext(text: 'Welcome to food App'),
                  SizedBox(height: 60),

                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            Customtextfield(
                              hint: 'Name',
                              isPassword: false,
                              controller: nameCtrl,
                            ),
                            SizedBox(height: 15),
                            Customtextfield(
                              hint: 'Email address',
                              isPassword: false,
                              controller: emailCtrl,
                            ),
                            SizedBox(height: 15),
                            Customtextfield(
                              hint: 'Password',
                              isPassword: true,
                              controller: passCtrl,
                            ),
                            SizedBox(height: 30),
                            isLoading
                                ? CupertinoActivityIndicator()
                                : CustomAuthButton(
                                    text: 'Sign up',
                                    color: Colors.white,
                                    textColor: AppColors.primary,
                                    onTap: () {
                                      if (frmkey.currentState!.validate()) {
                                        signup();
                                      }
                                    },
                                    isBordered: false,
                                  ),
                            const SizedBox(height: 15),

                            // Signup Button
                            CustomAuthButton(
                              text: 'Go To Login',
                              color: Colors.transparent,
                              textColor: Colors.white,
                              isBordered: true,
                              onTap: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const Loginscreen(),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
