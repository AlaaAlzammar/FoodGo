import 'package:flutter/material.dart';
import 'package:my_project/globals/app_color.dart';
import 'package:my_project/widgets/customText.dart';

class FoodCategory extends StatefulWidget {
  FoodCategory({
    super.key,
    required this.category,
    required this.selectedindex,
    this.onCategorySelected,
  });
  final int selectedindex;
  final List category;
  final Function(int)? onCategorySelected;

  @override
  State<FoodCategory> createState() => _FoodCategoryState();
}

class _FoodCategoryState extends State<FoodCategory> {
  late int selectedIndex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedIndex = widget.selectedindex;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(widget.category.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: selectedIndex == index
                    ? AppColors.primary
                    : Color(0xffF3F4F6),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Customtext(
                text: widget.category[index],
                weight: FontWeight.w600,
                color: selectedIndex == index ? Colors.white : Colors.grey,
              ),
            ),
          );
        }),
      ),
    );
  }
}
