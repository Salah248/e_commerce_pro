import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_commerce_pro/resources/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: ConstantManager.baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {'Content-Type': 'application/json'},
    ),
  )..interceptors.add(PrettyDioLogger());

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final Response response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Response> post(
    String url,
    Map<String, dynamic> data, {
    Options? options,
  }) async {
    try {
      final Response response = await dio.post(
        url,
        data: data,
        options: options,
      );
      return response; // إرجاع النتيجة
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Response> put(
    String url, {
    Map<String, dynamic>? data,
    Options? options,
  }) async {
    try {
      final Response response = await dio.put(
        url,
        data: data,
        options: options,
      );
      return response; // إرجاع النتيجة
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
