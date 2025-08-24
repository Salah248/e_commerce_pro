import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:e_commerce_pro/data/model/products_model.dart';
import 'package:e_commerce_pro/data/services/dio_servecis.dart';
import 'package:e_commerce_pro/di.dart';
import 'package:e_commerce_pro/resources/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsProvider extends StateNotifier<AsyncValue<List<ProductsModel>>> {
  ProductsProvider() : super(const AsyncValue.loading());

  Future<void> getProducts() async {
    log('get products called');
    try {
      final response = await di<DioService>().get(
        ConstantManager.getProductsUrl,
      );

      // استجابة API هي List من المنتجات
      final List<dynamic> jsonList = response as List<dynamic>;
      final List<ProductsModel> products = jsonList
          .map((e) => ProductsModel.fromJson(e))
          .toList();

      state = AsyncValue.data(products); // ← تحديث الحالة هنا
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
      final jsonList = response as List<dynamic>;
      final List<ProductsModel> productsCategory = jsonList.map((e) {
        return ProductsModel.fromJson(e);
      }).toList();
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
