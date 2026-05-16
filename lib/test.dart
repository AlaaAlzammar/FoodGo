import 'package:dio/dio.dart';

void test() async {
  try {
    final response = await Dio().get('');
    print(response.data);
  } on DioException catch (e) {
    print(e.message);
  }
}
