import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di.dart';
import '../../../../core/model/cart_model.dart';
import '../../../../core/services/repo/repo.dart';

class CartProvider extends AsyncNotifier<List<CartModel>> {
  @override
  FutureOr<List<CartModel>> build() {
    return _getCarts();
  }

  Future<List<CartModel>> _getCarts() async {
    final response = await di<MainRepo>().getCarts();
    return response.fold((error) => throw Exception(error), (data) => data);
  }

  Future<void> refreshCart() async {
    state = const AsyncValue.loading();
    try {
      final carts = await _getCarts();
      state = AsyncValue.data(carts);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

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

final cartProvider = AsyncNotifierProvider<CartProvider, List<CartModel>>(
  () => CartProvider(),
);
