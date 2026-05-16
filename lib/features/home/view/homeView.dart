import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_project/features/cart/view/cartView.dart';
import 'package:my_project/features/home/data/home_provider.dart';
import 'package:my_project/features/home/data/models/product_model.dart';
import 'package:my_project/features/home/data/product_repo.dart';
import 'package:my_project/features/home/view/widgets/card_item.dart';
import 'package:my_project/features/home/view/widgets/food_category.dart';
import 'package:my_project/features/home/view/widgets/search_field.dart';
import 'package:my_project/features/home/view/widgets/user_header.dart';
import 'package:my_project/features/product/views/product_details_view.dart';
import 'package:provider/provider.dart';

class Homeview extends StatefulWidget {
  const Homeview({super.key});

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  List category = ['All', 'Combo', 'Sliders', 'Classic'];
  int selected = 0;
  late Future<List<ProductModel?>> products;
  ProductRepo productRepo = ProductRepo();
  final TextEditingController controller = TextEditingController();

  List<ProductModel> allProducts = [];
  List<ProductModel> filteredProducts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    products = ProductRepo().getProducts().then((data) {
      allProducts = data.whereType<ProductModel>().toList();
      filteredProducts = allProducts;
      return data;
    });
  }

  void filterSearchResults(String query) {
    setState(() {
      filteredProducts = allProducts
          .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            //header
            SliverAppBar(
              elevation: 0,
              scrolledUnderElevation: 0,
              pinned: true,
              floating: false,
              backgroundColor: Colors.white,
              toolbarHeight: 180,
              automaticallyImplyLeading: false,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Column(
                  children: [
                    UserHeader(),
                    SearchField(
                      controller: provider.controller,
                      onChanged: (v) {
                        provider.filterSearchResults(v);
                      },
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                child: FoodCategory(
                  category: category,
                  selectedindex: selected,
                  onCategorySelected: (index) {
                    setState(() {
                      selected = index;
                    });
                  },
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              sliver: FutureBuilder<List<ProductModel?>>(
                future: provider.products,
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

                  return SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      childCount: provider.filteredProducts.length,
                      (context, index) {
                        final product = provider.filteredProducts[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) {
                                  return ProductDetailsView(
                                    productId: product.id,
                                    productPrice: product.price,
                                  );
                                },
                              ),
                            );
                          },
                          child: CardItem(
                            image: product.image,
                            text: product.name,
                            desc: product.desc,
                            rate: product.rate,
                          ),
                        );
                      },
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
