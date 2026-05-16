import 'package:flutter/material.dart';

import 'package:my_project/widgets/customText.dart';
import 'package:my_project/widgets/custom_button.dart';

class Orderhistoryview extends StatelessWidget {
  const Orderhistoryview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: 120, top: 100),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/image 1.png', width: 100),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Customtext(
                            text: 'HUmburger',
                            weight: FontWeight.bold,
                          ),
                          Customtext(text: 'Quaintity: 3'),
                          Customtext(text: 'Price: 20\$'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    text: 'Order again',
                    width: double.infinity,
                    color: Colors.grey.shade400,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
