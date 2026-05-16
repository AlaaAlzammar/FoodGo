import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_project/globals/app_color.dart';
import 'package:my_project/widgets/customText.dart';
import 'package:image_network/image_network.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key, this.userImage});
  final String? userImage;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/AppLogo.png',
              width: 80,
              color: AppColors.primary,
            ),
            Customtext(
              text: 'Order Your favorit food!',
              size: 12,
              weight: FontWeight.w500,
              color: Colors.grey.shade500,
            ),
          ],
        ),
        Spacer(),
        CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.primary,
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(20),
            child:
                //ImageNetwork(image: userImage, height: 20, width: 20) ??
                Icon(CupertinoIcons.person, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
