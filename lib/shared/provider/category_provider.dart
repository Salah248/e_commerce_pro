import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_commerce_pro/core/services/dio_servecis.dart';
import 'package:e_commerce_pro/core/di.dart';
import 'package:e_commerce_pro/core/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesProvider extends StateNotifier<AsyncValue<List<String>>> {
  CategoriesProvider() : super(const AsyncValue.loading());

  Future<void> getCategories() async {
    log('get category called');
    try {
      final response = await di<DioService>().get(
        ConstantManager.getCategoriesUrl,
      );

      final List<dynamic> jsonList = response.data;
      final List<String> category = jsonList.map((e) => e as String).toList();
      state = AsyncValue.data(category);
    } on DioException catch (e) {
      log(e.toString());
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final categoriesProvider =
    StateNotifierProvider<CategoriesProvider, AsyncValue<List<String>>>((ref) {
      return CategoriesProvider();
    });
