import 'package:my_project/core/services/api_error.dart';
import 'package:dio/dio.dart';

class ApiException {
  static ApiError handelError(DioException error) {
    final srtatusCode = error.response?.statusCode;
    final data = error.response?.data;
    if (srtatusCode != null) {
      if (data is Map<String, dynamic> && data["message"] != null) {
        return ApiError(message: data["message"], statusCode: srtatusCode);
      }
    }
    if (srtatusCode == 302) {
      throw ApiError(message: "this Email is already taken");
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(message: "Bad internet connection");
      case DioExceptionType.sendTimeout:
        return ApiError(message: "Requset timeout, Please try again");
      case DioException.receiveTimeout:
        return ApiError(message: "Response Timeout, please try again");
      default:
        return ApiError(message: 'Something went wrong');
    }
  }
}
