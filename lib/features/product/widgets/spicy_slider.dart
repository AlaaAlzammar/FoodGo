import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_project/globals/app_color.dart';
import 'package:my_project/widgets/customText.dart';

class SpicySlider extends StatelessWidget {
  const SpicySlider({super.key, required this.value, required this.onChanged});
  final double value;
  final ValueChanged<double> onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/pngwing 12.png', height: 250),
        Spacer(),
        Column(
          children: [
            Customtext(
              text:
                  'Customize your Burger\n to your Tastes \nUltimate Expirence',
            ),
            Slider(
              min: 0,
              max: 1,
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.primary,
              inactiveColor: Colors.grey.shade300,
            ),
            Row(
              children: [
                Customtext(text: 'Mild', color: Colors.green),
                SizedBox(width: 100),
                Customtext(text: 'Hot', color: Colors.red),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
