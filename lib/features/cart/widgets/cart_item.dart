import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_project/globals/app_color.dart';
import 'package:my_project/widgets/customText.dart';
import 'package:image_network/image_network.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.image,
    required this.text,
    required this.desc,
    this.onAdd,
    this.onMin,
    this.onRemove,
    required this.number,
  });
  final String image, text, desc;
  final int number;

  final Function()? onAdd;
  final Function()? onMin;
  final Function()? onRemove;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageNetwork(image: image, width: 100, height: 100),
              Customtext(text: text),
              Expanded(child: Customtext(text: desc)),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: onAdd,
                    child: CircleAvatar(
                      backgroundColor: AppColors.primary,
                      child: Icon(CupertinoIcons.add, color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 20),
                  Customtext(
                    text: number.toString(),
                    weight: FontWeight.w700,
                    size: 20,
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: onMin,
                    child: CircleAvatar(
                      backgroundColor: AppColors.primary,
                      child: Icon(CupertinoIcons.minus, color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: onRemove,
                child: Container(
                  width: 130,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.primary,
                  ),
                  child: Center(
                    child: Customtext(text: 'Remove', color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
