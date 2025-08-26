import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_pro/core/model/token_model.dart';
import 'package:e_commerce_pro/core/services/dio_servecis.dart';
import 'package:e_commerce_pro/core/utils/constants.dart';

class AuthRepository {
  final DioService dio;
  AuthRepository(this.dio);
  Future<Either<String, TokenModel>> postLogin(
    Map<String, dynamic> data,
  ) async {
    log('posted login in repo');
    try {
      final response = await dio.post(ConstantManager.loginUrl, data: data);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final tokenModel = TokenModel.fromJson(response.data);
        log('tokenModel: ${tokenModel.token}');
        return Right(tokenModel);
      } else {
        return Left(response.data);
      }
    } on DioException catch (e) {
      log(e.response!.data.toString());
      return Left(e.response?.data ?? 'an error occured');
    }
  }

  Future<Either<String, dynamic>> postSignup(Map<String, dynamic> data) async {
    log('posted signup in repo');
    try {
      await dio.post(ConstantManager.registerUrl, data: data);
      return const Right('Success');
    } on DioException catch (e) {
      log(e.response!.data.toString());
      return Left(e.response?.data ?? 'an error occured');
    } finally {
      log('login success');
    }
  }
}
