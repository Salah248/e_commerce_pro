import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_commerce_pro/core/services/interceptors.dart';
import 'package:e_commerce_pro/core/utils/constants.dart';

class DioService {
  late final Dio _dio;
  DioService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: ConstantManager.baseUrl,
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          responseType: ResponseType.json,
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      )..interceptors.addAll([LoggerInterceptor()]);
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final Response response = await _dio.get(
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
    String url, {
    Map<String, dynamic>? data,
    Options? options,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        options: options,
      );
      return response; // إرجاع النتيجة
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Response> put(
    String url, {
    Map<String, dynamic>? data,
    Options? options,
  }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        options: options,
      );
      return response; // إرجاع النتيجة
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
