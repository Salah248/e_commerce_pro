import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_pro/core/model/cart_model.dart';
import 'package:e_commerce_pro/core/model/categories_model.dart';
import 'package:e_commerce_pro/core/model/products_model.dart';
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

class MainRepo {
  final DioService dio;
  MainRepo(this.dio);
  Future<Either<String, List<ProductsModel>>> getProducts() async {
    log('got products in repo');
    try {
      final response = await dio.get(ConstantManager.getProductsUrl);
      if (response.statusCode! >= 200 &&
          response.statusCode! < 300 &&
          response.data != null) {
        final products = (response.data as List)
            .map((e) => ProductsModel.fromJson(e))
            .toList();
        log('product: ${products.first}');
        return Right(products);
      } else {
        return Left(response.data);
      }
    } on DioException catch (e) {
      log(e.toString());
      return Left(e.response?.data ?? 'an error occured');
    }
  }

  Future<Either<String, List<CategoriesModel>>> getCategories() async {
    log('got categories in repo');
    try {
      final response = await dio.get(ConstantManager.getCategoriesUrl);
      if (response.statusCode! >= 200 &&
          response.statusCode! < 300 &&
          response.data != null) {
        final category = (response.data as List)
            .map((e) => CategoriesModel.fromJson(e as String))
            .toList();
        log('product: ${category.first}');
        return Right(category);
      } else {
        return Left(response.data);
      }
    } on DioException catch (e) {
      log(e.toString());
      return Left(e.response?.data ?? 'an error occured');
    }
  }

  Future<Either<String, List<ProductsModel>>> getProductsByCategory(
    String category,
  ) async {
    log('got getProductsByCategory in repo');
    try {
      final response = await dio.get(
        ConstantManager.getCategoryProductsUrl + category,
      );
      if (response.statusCode! >= 200 &&
          response.statusCode! < 300 &&
          response.data != null) {
        final productCategory = (response.data as List)
            .map((e) => ProductsModel.fromJson(e))
            .toList();
        log('product: ${productCategory.first}');
        return Right(productCategory);
      } else {
        return Left(response.data);
      }
    } on DioException catch (e) {
      log(e.toString());
      return Left(e.response?.data ?? 'an error occured');
    }
  }

  Future<Either<String, List<CartModel>>> getCarts() async {
    log('got getCarts in repo');
    try {
      final response = await dio.get(ConstantManager.getCartUrl);
      if (response.statusCode! >= 200 &&
          response.statusCode! < 300 &&
          response.data != null) {
        final cart = (response.data as List)
            .map((e) => CartModel.fromJson(e))
            .toList();
        log('cart: ${cart.first}');
        return Right(cart);
      } else {
        return Left(response.data);
      }
    } on DioException catch (e) {
      log(e.toString());
      return Left(e.response?.data ?? 'an error occured');
    }
  }

  Future<Either<String, CartModel>> updateCart({
    Map<String, dynamic>? data,
  }) async {
    log('updateCart in repo called');
    try {
      final response = await dio.put(
        '${ConstantManager.addOrgetCartUrl}/3',
        data: data,
      );
      if (response.statusCode! >= 200 &&
          response.statusCode! < 300 &&
          response.data != null) {
        final cart = CartModel.fromJson(response.data);
        log('cart: $cart');
        return Right(cart);
      } else {
        return Left(response.data.toString());
      }
    } on DioException catch (e) {
      log(e.toString());
      return Left(e.response?.data.toString() ?? 'an error occured');
    }
  }

  // إضافة دالة لإنشاء عربة جديدة
  Future<Either<String, CartModel>> createCart({
    Map<String, dynamic>? data,
  }) async {
    log('createCart in repo called');
    try {
      final response = await dio.post(
        ConstantManager.addOrgetCartUrl,
        data: data,
      );
      if (response.statusCode! >= 200 &&
          response.statusCode! < 300 &&
          response.data != null) {
        final cart = CartModel.fromJson(response.data);
        log('cart: $cart');
        return Right(cart);
      } else {
        return Left(response.data.toString());
      }
    } on DioException catch (e) {
      log(e.toString());
      return Left(e.response?.data.toString() ?? 'an error occured');
    }
  }
}
