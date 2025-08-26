import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:e_commerce_pro/core/model/products_model.dart';
import 'package:e_commerce_pro/core/services/dio_servecis.dart';
import 'package:e_commerce_pro/core/di.dart';
import 'package:e_commerce_pro/core/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsProvider extends StateNotifier<AsyncValue<List<ProductsModel>>> {
  ProductsProvider() : super(const AsyncValue.loading());

  Future<void> getProducts() async {
    log('get products called');
    try {
      final response = await di<DioService>().get(
        ConstantManager.getProductsUrl,
      );

      final List<dynamic> jsonList = response.data;
      final List<ProductsModel> product = jsonList
          .map((json) => ProductsModel.fromJson(json))
          .toList();
      state = AsyncValue.data(product); // ← تحديث الحالة هنا
    } on DioException catch (e) {
      log(e.toString());
      state = AsyncValue.error(e, StackTrace.current); // ← في حالة الخطأ
    }
  }

  Future<void> getCategoryProducts({String? category}) async {
    log('get category products called');
    try {
      final response = await di<DioService>().get(
        '${ConstantManager.getCategoryProductsUrl}$category',
      );
      // استجابة API هي List من المنتجات
      final jsonList = response.data;
      final List<ProductsModel> productsCategory = jsonList
          .map((json) => ProductsModel.fromJson(json))
          .toList()
          .cast<ProductsModel>();
      state = AsyncValue.data(productsCategory); // ← تحديث الحالة هنا
    } on DioException catch (e) {
      log(e.toString());
      state = AsyncValue.error(e, StackTrace.current); // ← في حالة الخطأ
    }
  }
}

final productsProvider =
    StateNotifierProvider<ProductsProvider, AsyncValue<List<ProductsModel>>>((
      ref,
    ) {
      return ProductsProvider();
    });
