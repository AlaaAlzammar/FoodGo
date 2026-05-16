import 'package:flutter/material.dart';
import 'package:my_project/widgets/customText.dart';
import 'package:image_network/image_network.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.image,
    required this.text,
    required this.desc,
    required this.rate,
  });
  final String image, text, desc, rate;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: ImageNetwork(image: image, width: 120, height: 120)),
            SizedBox(height: 15),
            Customtext(text: text, weight: FontWeight.bold),
            SizedBox(height: 5),
            Customtext(text: desc, size: 12),
            SizedBox(height: 10),
            Customtext(text: ' $rate ⭐', weight: FontWeight.bold),
          ],
        ),
      ),
    );
  }
}
