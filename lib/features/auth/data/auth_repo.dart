import 'package:my_project/core/Utils/pref_helper.dart';

import 'package:my_project/core/services/api_error.dart';
import 'package:my_project/core/services/api_exception.dart';
import 'package:my_project/core/services/api_service.dart';
import 'package:my_project/features/auth/data/user_model.dart';
import 'package:dio/dio.dart';

class AuthRepo {
  final ApiService apiService = ApiService.api;
  bool isGuest = false;
  UserModel? _currentUser;
  // login
  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await apiService.post('/login', {
        "email": email,
        "password": password,
      });
      if (response is Map<String, dynamic>) {
        final meg = response['messege'];
        final code = response['code'];
        final data = response['data'];
        if (code != 200 || data == null) {
          throw ApiError(message: meg);
        }
        final user = UserModel.fromJson(response["data"]);
        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
        }
        isGuest = false;
        _currentUser = user;
        return user;
      } else {
        throw ApiError(message: 'UnExeptected Error from server');
      }
    } on DioException catch (e) {
      throw ApiException.handelError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  //sign up
  Future<UserModel?> signup(String name, String email, String password) async {
    print("🚀 SIGNUP CALLED with: $name, $email");
    try {
      final response = await apiService.post('/register', {
        "name": name,
        "password": password,
        "email": email,
      });
      print(response);
      if (response is ApiError) {
        print(response);
        throw response;
      }
      if (response is Map<String, dynamic>) {
        final meg = response['message'];
        final code = response['code'];

        final data = response['data'];
        if (data == null) {
          throw ApiError(message: "No user data returned");
        }

        //
        if (code != 200 && code != 201) {
          throw ApiError(message: meg ?? 'unknown error');
        }
        final user = UserModel.fromJson(data);
        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
        }
        isGuest = false;
        _currentUser = user;
        return user;
      } else {
        print(response);
        throw ApiError(message: "UNexpected error");
      }
    } on DioException catch (e) {
      print("❌ ERROR STATUS: ${e.response?.statusCode}");
      print("❌ ERROR DATA: ${e.response?.data}");
      print("❌ ERROR TYPE: ${e.type}");

      throw ApiException.handelError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  //get profile data
  Future<UserModel?> getProfileData() async {
    try {
      final token = await PrefHelper.getToken();
      if (token == null || token == 'guest') {
        return null;
      }
      final response = await apiService.get('/profile');
      final user = UserModel.fromJson(response["data"]);
      _currentUser = user;

      return user;
    } on DioException catch (e) {
      ApiException.handelError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  //update

  Future<UserModel?> updateProfileData({
    required String name,
    required String email,
    required String address,
    String? visa,
    String? imagePath,
  }) async {
    try {
      final formData = FormData.fromMap({
        "name": name,
        "email": email,
        "address": address,
        if (visa != null && visa.isNotEmpty) "Vise": visa,
        if (imagePath != null && imagePath.isNotEmpty)
          "image": await MultipartFile.fromFile(
            imagePath,
            filename: 'profile.jbg',
          ),
      });
      final response = await apiService.post('/update-profile', formData);
      if (response is ApiError) {
        throw response;
      }
      if (response is Map<String, dynamic>) {
        final meg = response['messege'];
        final code = response['code'];
        final coder = int.tryParse(code);
        final data = response['data'];

        if (coder != 200 && coder != 201) {
          throw ApiError(message: meg);
        }
        final updatedUser = UserModel.fromJson(data);
        _currentUser = updatedUser;
        return updatedUser;
        //
      }
    } on DioException catch (e) {
      throw ApiException.handelError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  // logout
  Future<void> logout() async {
    final response = await apiService.post('/logout', {});
    if (response["data"] != null) {
      throw ApiError(message: 'error');
    }
    await PrefHelper.clearToken();
    _currentUser = null;
    isGuest = true;
  }

  // auto login
  Future<UserModel?> autoLogin() async {
    final token = await PrefHelper.getToken();
    if (token == null || token == 'guest') {
      isGuest = true;
      _currentUser = null;
      return null;
    }
    isGuest = false;
    try {
      final user = await getProfileData();
      _currentUser = user;
      return user;
    } catch (e) {
      await PrefHelper.clearToken();
      isGuest = true;
      _currentUser = null;
      return null;
    }
  }

  // continu as guest
  Future<void> continueAsGuest() async {
    isGuest = true;
    _currentUser = null;
    await PrefHelper.saveToken('guest');
  }

  UserModel? get currentUser => _currentUser;
  bool get isLogging => !isGuest && currentUser != null;
}
