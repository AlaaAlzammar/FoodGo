import 'package:my_project/core/services/api_client.dart';
import 'package:dio/dio.dart';
import 'package:my_project/core/services/api_exception.dart';

class ApiService {
  final Dioclient _dioclient = Dioclient();
  ApiService._();
  static final ApiService api = ApiService._();

  Future<dynamic> get(String endPoint, {dynamic param}) async {
    try {
      final response = await _dioclient.dio.get(
        endPoint,
        queryParameters: param,
      );
      return response.data;
    } on DioException catch (e) {
      return ApiException.handelError(e);
    }
  }

  Future<dynamic> post(String endPoint, dynamic body) async {
    print(body);
    try {
      print(body);
      final response = await _dioclient.dio.post(endPoint, data: body);
      print("✅ RESPONSE (${response.statusCode}): ${response.data}");
      return response.data;
    } on DioException catch (e) {
      print("i ame $e");
      print("❌ DIO ERROR STATUS: ${e.response?.statusCode}");
      print("❌ DIO ERROR DATA: ${e.response?.data}");
      throw ApiException.handelError(e); // 🔥 THROW, NOT RETURN
    }
  }

  Future<dynamic> put(String endPoint, dynamic body) async {
    try {
      final response = await _dioclient.dio.post(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      return ApiException.handelError(e);
    }
  }

  Future<dynamic> delete(
    String endPoint,
    Map<String, dynamic> body, {
    dynamic parameter,
  }) async {
    try {
      final response = await _dioclient.dio.delete(
        endPoint,
        data: body,
        queryParameters: parameter,
      );
      return response.data;
    } on DioException catch (e) {
      return ApiException.handelError(e);
    }
  }
}
