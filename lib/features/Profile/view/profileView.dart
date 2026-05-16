import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_project/core/services/api_error.dart';
import 'package:my_project/features/auth/data/auth_repo.dart';
import 'package:my_project/features/auth/data/user_model.dart';
import 'package:my_project/globals/app_color.dart';
import 'package:my_project/screens/loginScreen.dart';
import 'package:my_project/screens/signupScreen.dart';
import 'package:my_project/widgets/customText.dart';
import 'package:my_project/widgets/customTextField.dart';
import 'package:my_project/widgets/custom_auth_button.dart';
import 'package:my_project/widgets/custom_button.dart';
import 'package:my_project/widgets/custom_snackBar.dart';
import 'package:image_picker/image_picker.dart';

class Profileview extends StatefulWidget {
  const Profileview({super.key});

  @override
  State<Profileview> createState() => _ProfileviewState();
}

class _ProfileviewState extends State<Profileview> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController address = TextEditingController();
  UserModel? userModel;
  bool isLoading = false;

  AuthRepo authRepo = AuthRepo();
  String? selectedimage;
  bool isguest = false;
  Future<void> autoLogin() async {
    final user = await authRepo.autoLogin();
    setState(() {
      isguest = authRepo.isGuest;
    });
    if (user != null) {
      setState(() {
        userModel = user;
      });
    }
  }

  Future<void> getProfileData() async {
    try {
      final user = await authRepo.getProfileData();
      setState(() {
        userModel = user;
      });
    } catch (e) {
      String errorMes = "Error in Profile";
      if (e is ApiError) {
        errorMes = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(errorMes));
    }
  }

  Future<void> updateProfielData() async {
    try {
      setState(() {
        isLoading = true;
      });
      final user = await authRepo.updateProfileData(
        name: name.text.trim(),
        email: email.text.trim(),
        address: address.text.trim(),
        imagePath: selectedimage,
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(customSnackBar("Profile updated succesfuly"));
      setState(() {
        userModel = user;
      });
      setState(() {
        isLoading = false;
      });

      await getProfileData();
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      String errorMes = "Error in Profile";
      if (e is ApiError) {
        errorMes = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(errorMes));
    }
  }

  Future<void> pickimage() async {
    final pickedimage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedimage != null) {
      selectedimage = pickedimage.path;
    }
  }

  Future<void> logout() async {
    await authRepo.logout();
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) {
          return Loginscreen();
        },
      ),
    );
  }

  @override
  void initState() {
    autoLogin();
    // TODO: implement initState
    getProfileData().then((v) {
      name.text = userModel?.name.toString() ?? 'Alaa Alzammar';
      email.text = userModel?.email.toString() ?? 'Alaa.Alzammar@gmail.com';
      address.text = userModel?.address == null
          ? 'Maghazi camp'
          : userModel!.address!;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!isguest) {
      return RefreshIndicator(
        displacement: 60,
        color: AppColors.primary,
        onRefresh: () async {
          await getProfileData();
        },
        child: Scaffold(
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 100),
                Row(),
                userModel == null
                    ? CupertinoActivityIndicator()
                    : Center(
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,

                            border: Border.all(
                              width: 2,
                              color: AppColors.primary,
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: selectedimage != null
                              ? Image.file(File(selectedimage!))
                              : (userModel?.image != null &&
                                    userModel!.image!.isNotEmpty)
                              ? Image.network(
                                  userModel!.image!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(Icons.person),
                                )
                              : Icon(Icons.person),
                        ),
                      ),
                SizedBox(height: 10),
                CustomButton(
                  onTap: pickimage,
                  text: 'upload image',
                  width: 138,
                  height: 10,
                  raduis: 50,
                ),
                SizedBox(height: 30),
                Customtextfield(
                  hint: 'Name',
                  isPassword: false,
                  controller: name,
                ),
                SizedBox(height: 25),
                Customtextfield(
                  hint: 'Email',
                  isPassword: false,
                  controller: email,
                ),
                SizedBox(height: 25),
                Customtextfield(
                  hint: 'Address',
                  isPassword: false,
                  controller: address,
                ),
                SizedBox(height: 25),
                Divider(),
              ],
            ),
          ),
          bottomSheet: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.grey.shade800, blurRadius: 20),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                isLoading
                    ? CircularProgressIndicator()
                    : GestureDetector(
                        onTap: updateProfielData,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Customtext(
                                text: 'Edit Profile',
                                weight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              SizedBox(width: 4),
                              Icon(CupertinoIcons.pencil, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return Loginscreen();
                        },
                      ),
                    );
                  },
                  child: GestureDetector(
                    onTap: logout,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.primary),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Customtext(text: 'Logout', color: AppColors.primary),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (isguest) {
      return _buildGuestView();
    }
    return SizedBox();
  }

  Widget _buildGuestView() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_outline,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),

                const Customtext(
                  text: 'Guest Mode',
                  weight: FontWeight.bold,
                  size: 28,
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
                const Customtext(
                  text: 'Please login to view and edit your profile details.',
                  color: Colors.white70,
                  size: 16,
                ),
                const SizedBox(height: 40),

                // Login Button
                CustomAuthButton(
                  text: 'Login',
                  color: Colors.white,
                  textColor: AppColors.primary,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Loginscreen()),
                  ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGuestButton({
    required String text,
    required Color color,
    required Color textColor,
    required VoidCallback onTap,
    bool isBordered = false,
  }) {
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
  }
}
