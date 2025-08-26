import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_commerce_pro/core/model/cart_model.dart';
import 'package:e_commerce_pro/core/model/products_model.dart';
import 'package:e_commerce_pro/core/services/dio_servecis.dart';
import 'package:e_commerce_pro/core/di.dart';
import 'package:e_commerce_pro/core/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateCartProvider extends StateNotifier<List<CartModel>> {
  UpdateCartProvider(super.state);

  Future<void> addToCart({
    int? id,
    String? date,
    ProductsModel? product,
    int? quantity,
  }) async {
    try {
      final response = await di<DioService>().put(
        '${ConstantManager.addOrgetCartUrl}/${id ?? 3}',
        data: {
          'userId': 2,
          'date': date,
          'products': [
            {'productId': product?.id, 'quantity': quantity},
          ],
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is List) {
          final List<dynamic> data = response.data;
          state = data.map((e) => CartModel.fromJson(e)).toList();
        } else if (response.data is Map) {
          final CartModel cart = CartModel.fromJson(response.data);
          state = [...state, cart];
        }
      } else {
        throw Exception('Failed to update cart: ${response.statusCode}');
      }
    } on DioException catch (e) {
      log('Error: ${e.response?.data ?? e.message}');
    }
  }

  void increment(int cartIndex, int productIndex) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == cartIndex)
          CartModel(
            id: state[i].id,
            userId: state[i].userId,
            date: state[i].date,
            products: [
              for (int j = 0; j < state[i].products!.length; j++)
                if (j == productIndex)
                  state[i].products![j].copyWith(
                    quantity: state[i].products![j].quantity! + 1,
                  )
                else
                  state[i].products![j],
            ],
            iV: state[i].iV,
          )
        else
          state[i],
    ];
  }

  void decrement(int cartIndex, int productIndex) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == cartIndex)
          CartModel(
            id: state[i].id,
            userId: state[i].userId,
            date: state[i].date,
            products: [
              for (int j = 0; j < state[i].products!.length; j++)
                if (j == productIndex && state[i].products![j].quantity! > 1)
                  state[i].products![j].copyWith(
                    quantity: state[i].products![j].quantity! - 1,
                  )
                else
                  state[i].products![j],
            ],
            iV: state[i].iV,
          )
        else
          state[i],
    ];
  }
}

final updateCartProvider =
    StateNotifierProvider<UpdateCartProvider, List<CartModel>>(
      (ref) => UpdateCartProvider([]),
    );
