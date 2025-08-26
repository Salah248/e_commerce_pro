import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_commerce_pro/data/model/cart_model.dart';
import 'package:e_commerce_pro/data/services/dio_servecis.dart';
import 'package:e_commerce_pro/di.dart';
import 'package:e_commerce_pro/resources/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartProvider extends StateNotifier<AsyncValue<List<CartModel>>> {
  CartProvider() : super(const AsyncValue.loading());

  Future<void> getCarts() async {
    try {
      state = const AsyncValue.loading();
      final response = await di<DioService>().get(ConstantManager.getCartUrl);
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;
        final products = jsonList
            .map((e) => CartModel.fromJson(e as Map<String, dynamic>))
            .toList()
            .cast<CartModel>();
        state = AsyncValue.data(products);
      }
    } on DioException catch (e) {
      log(e.response!.data.toString());
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  // Add methods to update quantity directly in the cart provider
  void incrementQuantity(int cartIndex, int productIndex) {
    state.whenData((carts) {
      final updatedCarts = [...carts];
      final cart = updatedCarts[cartIndex];
      final products = [...cart.products!];

      products[productIndex] = products[productIndex].copyWith(
        quantity: (products[productIndex].quantity ?? 0) + 1,
      );

      updatedCarts[cartIndex] = cart.copyWith(products: products);
      state = AsyncValue.data(updatedCarts);
    });
  }

  void decrementQuantity(int cartIndex, int productIndex) {
    state.whenData((carts) {
      final updatedCarts = [...carts];
      final cart = updatedCarts[cartIndex];
      final products = [...cart.products!];

      final currentQuantity = products[productIndex].quantity ?? 0;
      if (currentQuantity > 1) {
        products[productIndex] = products[productIndex].copyWith(
          quantity: currentQuantity - 1,
        );

        updatedCarts[cartIndex] = cart.copyWith(products: products);
        state = AsyncValue.data(updatedCarts);
      }
    });
  }
}

final cartProvider =
    StateNotifierProvider<CartProvider, AsyncValue<List<CartModel>>>(
      (ref) => CartProvider(),
    );
