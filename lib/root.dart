import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_project/features/Profile/view/profileView.dart';
import 'package:my_project/features/cart/view/cartView.dart';
import 'package:my_project/features/home/view/homeView.dart';
import 'package:my_project/features/orderHistory/view/orderHistoryView.dart';
import 'package:my_project/globals/app_color.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late PageController controller = PageController();
  late List<Widget> screens;
  int currentScreen = 0;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    controller = PageController(initialPage: currentScreen);
    // TODO: implement initState
    screens = [Homeview(), Cartview(), Orderhistoryview(), Profileview()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentScreen, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentScreen,
        elevation: 0,
        backgroundColor: AppColors.primary,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,

        unselectedItemColor: Colors.grey.shade500.withOpacity(0.7),
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_restaurant_sharp),
            label: 'Order History',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled),
            label: 'Profiles',
          ),
        ],
        onTap: (value) {
          setState(() {
            currentScreen = value;
          });
          controller.jumpToPage(currentScreen);
        },
      ),
    );
  }
}
