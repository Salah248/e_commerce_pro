import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_commerce_pro/core/model/cart_model.dart';
import 'package:e_commerce_pro/core/model/products_model.dart';
import 'package:e_commerce_pro/core/di.dart';
import 'package:e_commerce_pro/core/services/repo/repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateCartProvider extends StateNotifier<CartModel> {
  UpdateCartProvider() : super(CartModel());

  Future<void> addToCart({
    int? id,
    String? date,
    ProductsModel? product,
    int? quantity,
  }) async {
    try {
      final response = await di<MainRepo>().updateCart(
        data: {
          'userId': id,
          'date': date,
          'products': [
            {'productId': product?.id, 'quantity': quantity},
          ],
        },
      );

      response.fold((error) => log('Error: $error'), (data) => state = data);
    } on DioException catch (e) {
      log('Error: ${e.response?.data ?? e.message}');
    }
  }
}

final updateCartProvider = StateNotifierProvider<UpdateCartProvider, CartModel>(
  (ref) => UpdateCartProvider(),
);
