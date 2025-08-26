import 'package:e_commerce_pro/shared/provider/category_provider.dart';
import 'package:e_commerce_pro/shared/provider/products_provider.dart';
import 'package:e_commerce_pro/core/theme/color_manager.dart';
import 'package:e_commerce_pro/core/routes/route_manager.dart';
import 'package:e_commerce_pro/core/theme/style_manager.dart';
import 'package:e_commerce_pro/shared/widgets/custom_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedCategory = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(productsProvider.notifier).getProducts();
      ref.read(categoriesProvider.notifier).getCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(productsProvider);
    final categoryState = ref.watch(categoriesProvider);
    return RefreshIndicator(
      onRefresh: () async {
        return await ref
            .read(productsProvider.notifier)
            .getProducts()
            .then(
              (value) => setState(() {
                _selectedCategory = null;
                _searchController.clear();
              }),
            );
      },
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Discover', style: StyleManager.headingTitle),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(child: _searchField()),
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
              ),
              SizedBox(height: 16.h),
              AnimationLimiter(
                child: SizedBox(
                  height: 36.h,
                  child: categoryState.when(
                    data: (data) {
                      if (data.isEmpty) return const SizedBox.shrink();
                      return ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 8.w),
                        itemCount: data.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                child: FadeInAnimation(
                                  child: _customCategory(data: data[index]),
                                ),
                              ),
                            ),
                      );
                    },
                    error: (error, stackTrace) => Center(
                      child: Text(
                        error.toString(),
                        style: StyleManager.cardTitle,
                      ),
                    ),
                    loading: () => ListView.separated(
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 8.w),
                      itemCount: 4,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          color: Colors.white,
                          margin: const EdgeInsets.all(8),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              AnimationLimiter(
                child: Expanded(
                  child: productsState.when(
                    data: (data) {
                      return GridView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        padding: EdgeInsets.only(top: 12.h),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 19.w,
                          mainAxisSpacing: 20.h,
                          childAspectRatio: 0.80,
                        ),
                        itemBuilder: (context, index) =>
                            AnimationConfiguration.staggeredGrid(
                              position: index,
                              columnCount: 2,
                              duration: const Duration(milliseconds: 375),
                              child: ScaleAnimation(
                                child: FadeInAnimation(
                                  child: _customItem(
                                    image: data[index].image,
                                    title: data[index].title,
                                    price: data[index].price!,
                                    extra: data[index],
                                  ),
                                ),
                              ),
                            ),
                      );
                    },
                    error: (error, stackTrace) => Center(
                      child: Text(
                        error.toString(),
                        style: StyleManager.cardTitle,
                      ),
                    ),
                    loading: () => GridView.builder(
                      shrinkWrap: true,
                      itemCount: 6, // عدد العناصر الوهمية أثناء التحميل
                      padding: EdgeInsets.only(top: 12.h),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 19.w,
                        mainAxisSpacing: 20.h,
                        childAspectRatio: 0.80,
                      ),
                      itemBuilder: (context, index) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          margin: const EdgeInsets.all(8),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchField() {
    void searchProducts(String query) {
      final products = ref.read(productsProvider).value ?? [];
      final filtered = products.where((product) {
        return product.title!.toLowerCase().contains(query.toLowerCase());
      }).toList();

      // ignore: invalid_use_of_visible_for_testing_member
      ref.read(productsProvider.notifier).state = AsyncValue.data(filtered);
    }

    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: const BorderSide(color: ColorManager.borderColor, width: 1),
    );
    return TextField(
      controller: _searchController,
      onChanged: (value) {
        if (!mounted) return;
        if (value.isEmpty) {
          ref.read(productsProvider.notifier).getProducts();
        } else {
          searchProducts(value);
        }
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20),
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        hintText: 'Search for clothes...',
        hintStyle: StyleManager.textFieldHint,
        prefixIcon: IconButton(
          style: IconButton.styleFrom(elevation: 0, padding: EdgeInsets.zero),
          onPressed: () {},
          icon: Icon(
            Icons.search,
            color: ColorManager.secondaryColor.withOpacity(.5),
          ),
        ),
      ),
    );
  }

  Widget _customCategory({String? data}) {
    final bool isSelected = data == _selectedCategory;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        fixedSize: Size.fromHeight(36.h),
        backgroundColor: isSelected
            ? ColorManager.primaryColor
            : ColorManager.whiteColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10.r),
          side: BorderSide(color: ColorManager.borderColor, width: 1.w),
        ),
      ),
      onPressed: () async {
        setState(() {
          _selectedCategory = data;
        });
        await ref
            .read(productsProvider.notifier)
            .getCategoryProducts(category: _selectedCategory);
      },
      child: Text(
        data ?? '',
        style: StyleManager.headingTitle.copyWith(
          color: isSelected
              ? ColorManager.whiteColor
              : ColorManager.primaryDarkColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _customItem({
    required String? image,
    required String? title,
    required double? price,
    Object? extra,
  }) {
    return GestureDetector(
      onTap: () {
        context.push(Routes.productDetails, extra: extra);
      },
      child: Container(
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Hero(
              tag: image!,
              child: CustomCachedNetworkImage(
                imageUrl: image,
                width: 161.w,
                height: 174.h,
              ),
            ),
            Text(
              title ?? '',
              style: StyleManager.cardTitle.copyWith(fontSize: 16.sp),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '\$ ${NumberFormat('#,##0.##').format(price ?? 0.0)}',
              style: StyleManager.textFieldHint.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
