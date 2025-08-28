import 'dart:async';

import 'package:e_commerce_pro/core/model/products_model.dart';
import 'package:e_commerce_pro/core/di.dart';
import 'package:e_commerce_pro/core/services/repo/repo.dart';
import 'package:e_commerce_pro/shared/provider/main/home/search_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsProvider extends AsyncNotifier<List<ProductsModel>> {
  List<ProductsModel> _all = [];
  @override
  Future<List<ProductsModel>> build() async {
    final result = await di<MainRepo>().getProducts();
    return result.fold((f) => throw Exception(f), (data) {
      _all = data;
      // استمع للـ searchProvider
      ref.listen<String>(searchProvider, (previous, next) {
        _filterProducts(next);
      });
      return data;
    });
  }

  Future<void> refreshProducts() async {
    state = const AsyncLoading();
    final result = await di<MainRepo>().getProducts();
    state = result.fold((f) => AsyncError(Exception(f), StackTrace.current), (
      data,
    ) {
      _all = data;
      return AsyncData(data);
    });
  }

  Future<void> getCategoryProducts({required String category}) async {
    state = const AsyncLoading();
    final result = await di<MainRepo>().getProductsByCategory(category);
    state = result.fold(
      (f) => AsyncError(Exception(f), StackTrace.current),
      (data) => AsyncData(data),
    );
  }

  void _filterProducts(String query) {
    if (query.isEmpty) {
      state = AsyncData(_all);
      return;
    }
    final filtered = _all
        .where(
          (e) => (e.title ?? '').toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    state = AsyncData(filtered);
  }
}

final productsProvider =
    AsyncNotifierProvider<ProductsProvider, List<ProductsModel>>(() {
      return ProductsProvider();
    });
