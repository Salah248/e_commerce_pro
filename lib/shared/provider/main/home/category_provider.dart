import 'dart:async';
import 'package:e_commerce_pro/core/di.dart';
import 'package:e_commerce_pro/core/model/categories_model.dart';
import 'package:e_commerce_pro/core/services/repo/repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesProvider extends AsyncNotifier<List<CategoriesModel>> {
  @override
  Future<List<CategoriesModel>> build() async {
    return await getCategories();
  }

  Future<List<CategoriesModel>> getCategories() async {
    state = const AsyncValue.loading();

    final response = await di<MainRepo>().getCategories();

    return response.fold((error) => throw Exception(error), (data) {
      // إنشاء قائمة جديدة وإضافة "All" في البداية
      final categoriesWithAll = [const CategoriesModel('All'), ...data];
      state = AsyncValue.data(categoriesWithAll);
      return categoriesWithAll;
    });
  }
}

final categoriesProvider =
    AsyncNotifierProvider<CategoriesProvider, List<CategoriesModel>>(
      () => CategoriesProvider(),
    );

final selectedCategoryProvider = StateProvider<String?>((ref) => 'All');
