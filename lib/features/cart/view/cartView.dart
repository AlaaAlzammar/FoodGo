import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_project/features/auth/data/auth_repo.dart';
import 'package:my_project/features/auth/data/user_model.dart';
import 'package:my_project/features/cart/data/cart_model.dart';
import 'package:my_project/features/cart/data/cart_repo.dart';
import 'package:my_project/features/cart/widgets/cart_item.dart';
import 'package:my_project/globals/app_color.dart';
import 'package:my_project/screens/loginScreen.dart';
import 'package:my_project/screens/signupScreen.dart';

import 'package:my_project/widgets/customText.dart';
import 'package:my_project/widgets/custom_auth_button.dart';
import 'package:my_project/widgets/custom_button.dart';
import 'package:my_project/widgets/custom_snackBar.dart';

class Cartview extends StatefulWidget {
  const Cartview({super.key});

  @override
  State<Cartview> createState() => _CartviewState();
}

class _CartviewState extends State<Cartview> {
  late List<int> quantities;

  CartRepo cartRepo = CartRepo();
  late Future<GetCartResponse?> cartResponse;
  bool isLoading = false;
  bool isGuest = false;
  AuthRepo authRepo = AuthRepo();
  UserModel? userModel;
  Future<void> autoLogin() async {
    final user = await authRepo.autoLogin();
    setState(() {
      isGuest = authRepo.isGuest;
    });
    if (user != null) {
      setState(() {
        userModel = user;
      });
    }
  }

  Future<void> removerCartitem(int id) async {
    try {
      setState(() {
        isLoading = true;
      });
      await cartRepo.removeCartitem(id);
      customSnackBar("item deleted");
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
    }
  }

  @override
  void initState() {
    cartResponse = CartRepo().getCartData();
    autoLogin();

    // TODO: implement initState
    super.initState();
  }

  void onAdd(int i) {
    setState(() {
      quantities[i]++;
    });
  }

  void onMin(int i) {
    setState(() {
      if (quantities[i] > 1) {
        quantities[i]--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isGuest) {
      return FutureBuilder(
        future: cartResponse,
        builder: (context, shot) {
          if (shot.connectionState == ConnectionState.waiting) {
            return SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            );
          }
          if (shot.hasError) {
            return SliverToBoxAdapter(
              child: Center(child: Text("Error loading products")),
            );
          }
          final cartList = shot.data!;
          final items = cartList.cartDate.items;
          quantities = List.generate(items.length, (index) => items[index].qty);

          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 0,
              scrolledUnderElevation: 0,
              backgroundColor: Colors.white,
              title: Customtext(
                text: "MY Cart",
                size: 24,
                weight: FontWeight.bold,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 120, top: 100),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = cartList.cartDate.items[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: isLoading
                        ? CircularProgressIndicator()
                        : CartItem(
                            image: item.image,
                            text: item.name,
                            desc: item.price,
                            number: quantities[index],
                            onAdd: () {
                              onAdd(index);
                            },
                            onMin: () {
                              onMin(index);
                            },
                            onRemove: () {
                              removerCartitem(item.itemId);
                            },
                          ),
                  );
                },
              ),
            ),
            bottomSheet: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    offset: Offset(0, 0),
                    color: Colors.grey.shade300,
                  ),
                ],
              ),
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Customtext(text: 'Total', size: 15),
                      Customtext(
                        text: '\$ ${cartList.cartDate.totalPrice}',
                        size: 24,
                      ),
                    ],
                  ),

                  CustomButton(text: 'Checkout ', onTap: () {}),
                ],
              ),
            ),
          );
        },
      );
    } else if (isGuest) {
      return _buildGuestView();
    }
    return SizedBox.shrink();
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
                  text: 'Please login to put items in Cart.',
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
}
