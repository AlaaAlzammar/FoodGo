import 'package:my_project/core/services/api_service.dart';
import 'package:my_project/features/home/data/models/category_model.dart';
import 'package:my_project/features/home/data/models/product_model.dart';
import 'package:my_project/features/home/data/models/topping_model.dart';

class ProductRepo {
  final ApiService apiService = ApiService.api;
  //get products
  Future<List<ProductModel?>> getProducts() async {
    try {
      final response = await apiService.get('/products');
      return (response["data"] as List)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
  //get topping

  Future<List<ToppingModel>> getToppings() async {
    try {
      final response = await apiService.get('/toppings');
      return (response["data"] as List)
          .map((e) => ToppingModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<ToppingModel>> getOptions() async {
    try {
      final response = await apiService.get('/side-options');
      return (response["data"] as List)
          .map((e) => ToppingModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  //search
  Future<List<ProductModel>> searchProducts(String name) async {
    try {
      final res = await apiService.get('products', param: {'name': name});
      return (res['data'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  //category
  Future<List<CategoryModel>> getCategories() async {
    final response = await apiService.get("categories");

    final List data = response.data['data'];

    return data.map((e) => CategoryModel.fromJson(e)).toList();
  }
}
