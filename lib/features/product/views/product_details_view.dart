import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_project/core/services/api_error.dart';
import 'package:my_project/features/cart/data/cart_model.dart';
import 'package:my_project/features/cart/data/cart_repo.dart';
import 'package:my_project/features/home/data/models/topping_model.dart';
import 'package:my_project/features/home/data/product_repo.dart';
import 'package:my_project/features/product/widgets/spicy_slider.dart';
import 'package:my_project/features/product/widgets/topping_card.dart';
import 'package:my_project/globals/app_color.dart';

import 'package:my_project/widgets/customText.dart';
import 'package:my_project/widgets/custom_button.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({
    super.key,
    required this.productId,
    required this.productPrice,
  });
  final int productId;
  final String productPrice;
  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  double value = 0.5;
  List<int> selectedToppings = [];
  List<int> selectedOptions = [];
  ProductRepo productRepo = ProductRepo();
  late Future<List<ToppingModel?>> toppings;
  late Future<List<ToppingModel?>> options;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    toppings = productRepo.getToppings();
    options = productRepo.getOptions();
  }

  //cart
  CartRepo cartRepo = CartRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,

        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SpicySlider(
              value: value,
              onChanged: (v) {
                setState(() {
                  value = v;
                });
              },
            ),
            SizedBox(height: 50),
            Customtext(text: 'Topping', size: 20),
            SizedBox(height: 70),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              child: FutureBuilder(
                future: toppings,
                builder: (context, shot) {
                  if (shot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (shot.hasError) {
                    return Center(child: Text("Error loading products"));
                  }
                  final toppingList = shot.data!;
                  return Row(
                    children: List.generate(toppingList.length, (index) {
                      final topping = toppingList[index];
                      final id = topping?.id;
                      final isSelecteditem = selectedToppings.contains(id);
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),

                        child: ToppingCard(
                          isSelected: isSelecteditem,
                          imageUrl: topping!.image,
                          title: topping.name,
                          onAdd: () {
                            final id = topping.id ?? 1;
                            setState(() {
                              if (selectedToppings.contains(id)) {
                                selectedToppings.remove(id);
                              } else {
                                selectedToppings.add(id);
                              }
                            });
                          },
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
            SizedBox(height: 30),
            Customtext(text: 'Side opreations ', size: 20),
            SizedBox(height: 70),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              child: FutureBuilder(
                future: options,
                builder: (context, shot) {
                  if (shot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (shot.hasError) {
                    return Center(child: Text("Error loading products"));
                  }
                  final optionList = shot.data!;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Row(
                      children: List.generate(optionList.length, (index) {
                        final option = optionList[index];
                        final id = option?.id;
                        final isSelecteditem = selectedOptions.contains(id);
                        return ToppingCard(
                          isSelected: isSelecteditem,
                          imageUrl: option!.image,
                          title: option.name,
                          onAdd: () {
                            final id = option.id ?? 1;
                            setState(() {
                              if (selectedOptions.contains(id)) {
                                selectedOptions.remove(id);
                              } else {
                                selectedOptions.add(id);
                              }
                            });
                          },
                        );
                      }),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 50),

            SizedBox(height: 100),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Customtext(text: 'Total', size: 20),
                  Customtext(
                    text: '\$ ${widget.productPrice}',
                    size: 27,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              CustomButton(
                widget: isLoading
                    ? CupertinoActivityIndicator(color: AppColors.primary)
                    : Icon(CupertinoIcons.cart_badge_plus),
                text: 'Add to Cart',
                textColor: AppColors.primary,
                color: Colors.white,
                onTap: () async {
                  try {
                    setState(() {
                      isLoading = true;
                    });
                    final cartitem = CartModel(
                      productId: widget.productId,
                      qty: 1,
                      spicy: value,
                      toppings: selectedToppings,
                      options: selectedToppings,
                    );
                    await cartRepo.addToCart(
                      CartRequestModel(items: [cartitem]),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Added to Cart Succesfully")),
                    );
                    setState(() {
                      isLoading = false;
                    });
                  } catch (e) {
                    setState(() {
                      isLoading = false;
                    });
                    throw ApiError(message: e.toString());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
