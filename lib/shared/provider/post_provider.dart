import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_pro/core/services/dio_servecis.dart';
import 'package:e_commerce_pro/core/di.dart';
import 'package:e_commerce_pro/core/services/repo/repo.dart';
import 'package:e_commerce_pro/core/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostProviderNotifier extends StateNotifier<Map<String, dynamic>> {
  PostProviderNotifier() : super({});

  Future<Either> postSignUp(Map<String, dynamic> data) async {
    log('postSignUp : in provider');
    try {
      final response = await di<AuthRepository>().postSignup(data);
      return Right(response);
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  Future<Either<String, dynamic>> postCart(Map<String, dynamic> data) async {
    print('posted cart');
    try {
      final response = await di<DioService>().post(
        ConstantManager.addOrgetCartUrl,
        data: data,
      );
      print('response: $response');
      return Right(response);
    } on DioException catch (e) {
      print(e);
      return Left(e.response?.data ?? 'An error occurred');
    } finally {
      print('success');
    }
  }
}

final postProvider =
    StateNotifierProvider<PostProviderNotifier, Map<String, dynamic>>(
      (ref) => PostProviderNotifier(),
    );
