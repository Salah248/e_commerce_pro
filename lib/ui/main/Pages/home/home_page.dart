import 'dart:async';

import 'package:e_commerce_pro/core/theme/color_manager.dart';
import 'package:e_commerce_pro/core/theme/style_manager.dart';
import 'package:e_commerce_pro/shared/provider/main/home/products_provider.dart';
import 'package:e_commerce_pro/ui/main/Pages/home/widgets/custom_product_list.dart';
import 'package:e_commerce_pro/ui/main/Pages/home/widgets/cutom_category_list.dart';
import 'package:e_commerce_pro/ui/main/Pages/home/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/provider/main/home/category_provider.dart';
import '../../../../shared/provider/main/home/search_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref.read(searchProvider.notifier).state = _searchController.text;
    });
  }

  Future<void> _handleRefresh() async {
    _searchController.clear();
    ref.read(selectedCategoryProvider.notifier).state = 'All';
    await Future.wait([
      ref.read(productsProvider.notifier).refreshProducts(),
      ref.read(categoriesProvider.notifier).getCategories(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Discover', style: StyleManager.headingTitle),
              SizedBox(height: 16.h),
              _buildSearchRow(),
              SizedBox(height: 16.h),
              const CategoriesList(),
              SizedBox(height: 10.h),
              const Expanded(child: ProductsGrid()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchRow() {
    return Row(
      children: [
        Expanded(child: CustomSearchField(controller: _searchController)),
        SizedBox(width: 8.w),
        IconButton(
          onPressed: () {},
          style: IconButton.styleFrom(
            backgroundColor: ColorManager.primaryColor,
            alignment: Alignment.center,
            fixedSize: Size(52.w, 52.w),
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          icon: const Icon(Icons.tune, color: Colors.white),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }
}
