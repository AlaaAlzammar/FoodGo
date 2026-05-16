import 'package:flutter/cupertino.dart';
import 'package:my_project/core/services/api_service.dart';
import 'package:my_project/features/home/data/models/product_model.dart';
import 'package:my_project/features/home/data/product_repo.dart';

class HomeProvider extends ChangeNotifier {
  late final ProductRepo productRepo = ProductRepo();
  late Future<List<ProductModel?>> products;
  final TextEditingController controller = TextEditingController();

  List<ProductModel> allProducts = [];
  List<ProductModel> filteredProducts = [];
  HomeProvider() {
    products = ProductRepo().getProducts().then((data) {
      allProducts = data.whereType<ProductModel>().toList();
      filteredProducts = allProducts;
      return data;
    });
  }
  void filterSearchResults(String query) {
    filteredProducts = allProducts
        .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
