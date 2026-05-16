import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

class ToppingCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback onAdd;
  final bool isSelected;
  final Color? color;
  const ToppingCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.onAdd,
    this.color,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            height: 85,
            width: 100,
            color: Color(0xff3C2F2F),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      GestureDetector(
                        onTap: onAdd,

                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: color ?? Colors.red,
                          child: Icon(
                            isSelected ? Icons.check : Icons.add,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -40,
          right: 0,
          left: 0,
          child: SizedBox(
            height: 80,
            width: 70,
            child: Card(
              color: Colors.white,
              child: ImageNetwork(image: imageUrl, height: 80, width: 70),
            ),
          ),
        ),
      ],
    );
  }
}
