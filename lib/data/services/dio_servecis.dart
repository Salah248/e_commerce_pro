import 'package:dio/dio.dart';
import 'package:e_commerce_pro/resources/constants.dart';

class DioService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: ConstantManager.baseUrl,
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 5000),
      headers: {'Content-Type': 'application/json'},
    ),
  );
  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data;
    } on DioError catch (e) {
      print(e);
      return e.response?.data;
    }
  }

  Future<void> post(
    String url,
    Map<String, dynamic> data, {
    Options? options,
  }) async {
    try {
      await dio.post(url, data: data, options: options);
    } on DioError catch (e) {
      print(e);
    }
  }
}
