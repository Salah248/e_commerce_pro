import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_pro/data/services/dio_servecis.dart';
import 'package:e_commerce_pro/di.dart';
import 'package:e_commerce_pro/resources/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostLoginNotifier extends StateNotifier<Map<String, dynamic>> {
  PostLoginNotifier() : super({});
  final dio = di<DioService>();

  Future<Either> postLogin(Map<String, dynamic> data) async {
    print('posted');
    try {
      await dio.post(ConstantManager.signupUrl, data);
      return const Right('login success');
    } on DioException catch (e) {
      print(e);
      return Left(e.response?.data ?? 'an error occured');
    } finally {
      print('login success');
    }
  }
}

final postLoginProvider =
    StateNotifierProvider<PostLoginNotifier, Map<String, dynamic>>(
      (ref) => PostLoginNotifier(),
    );
