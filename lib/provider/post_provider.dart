import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_pro/data/services/dio_servecis.dart';
import 'package:e_commerce_pro/di.dart';
import 'package:e_commerce_pro/resources/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostProviderNotifier extends StateNotifier<Map<String, dynamic>> {
  PostProviderNotifier() : super({});
  final dio = di<DioService>();

  Future<Either> postSignup(Map<String, dynamic> data) async {
    print('posted signup');
    try {
      await dio.post(ConstantManager.registerUrl, data);
      return const Right('Success');
    } on DioException catch (e) {
      print(e);
      return Left(e.response?.data ?? 'an error occured');
    } finally {
      print('login success');
    }
  }

  Future<Either<String, String>> postLogin(Map<String, dynamic> data) async {
    print('posted login');
    try {
      final response = await dio.post(ConstantManager.loginUrl, data);
      final token = response != null ? response.data['token'] : null;
      print('token: $token');
      return Right(token);
    } on DioException catch (e) {
      print(e);
      return Left(e.response?.data ?? 'An error occurred');
    } finally {
      print('login success');
    }
  }
}

final postProvider =
    StateNotifierProvider<PostProviderNotifier, Map<String, dynamic>>(
      (ref) => PostProviderNotifier(),
    );
