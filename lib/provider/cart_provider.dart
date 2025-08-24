import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_commerce_pro/data/model/cart_model.dart';
import 'package:e_commerce_pro/data/services/dio_servecis.dart';
import 'package:e_commerce_pro/di.dart';
import 'package:e_commerce_pro/resources/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartProvider extends StateNotifier<AsyncValue<List<CartModel>>> {
  CartProvider(super.state);
  Future<void> getCarts() async {
    try {
      final response = await di<DioService>().get(
        ConstantManager.addOrgetCartUrl,
      );
      if (response is List) {
        final products = response.map((e) => CartModel.fromJson(e)).toList();
        state = AsyncValue.data(products);
      } else {
        state = AsyncValue.error(
          Exception('Unexpected response: $response'),
          StackTrace.current,
        );
      }
    } on DioException catch (e) {
      log(e.response!.data.toString());
      state = AsyncValue.error(e, e.stackTrace);
    }
  }
}

final cartProvider =
    StateNotifierProvider<CartProvider, AsyncValue<List<CartModel>>>(
      (ref) => CartProvider(const AsyncValue.loading()),
    );
