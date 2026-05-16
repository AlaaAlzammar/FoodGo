import 'package:flutter/cupertino.dart';
import 'package:my_project/core/services/api_error.dart';
import 'package:my_project/core/services/api_service.dart';
import 'package:my_project/features/cart/data/cart_model.dart';

class CartRepo {
  final ApiService apiService = ApiService.api;
  Future<void> addToCart(CartRequestModel cartData) async {
    try {
      final res = await apiService.post('/cart/add', cartData.toJson());
      if (res['code'] == 200 && res['data'] == null) {
        throw ApiError(message: res['message']);
      }
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  Future<GetCartResponse?> getCartData() async {
    try {
      final res = await apiService.get('/cart');
      if (res is ApiError) {
        throw ApiError(message: res.message);
      }
      return GetCartResponse.fromJson(res);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  Future<void> removeCartitem(int id) async {
    try {
      final res = await apiService.delete('/cart/remove/$id', {});
      if (res['code'] == 200 && res['data'] == null) {
        throw ApiError(message: res['message']);
      }
    } catch (e) {
      throw ApiError(message: 'Remove item from cart');
    }
  }
}
