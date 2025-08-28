import 'package:e_commerce_pro/ui/main/Pages/home/widgets/custom_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/theme/style_manager.dart';
import '../../../../../shared/provider/main/home/category_provider.dart';
import '../../../../../shared/provider/main/home/products_provider.dart';

class CategoriesList extends ConsumerWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryState = ref.watch(categoriesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return AnimationLimiter(
      child: SizedBox(
        height: 36.h,
        child: categoryState.when(
          data: (data) {
            return ListView.separated(
              separatorBuilder: (context, index) => SizedBox(width: 8.w),
              itemCount: data.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: CustomCategoryOfProduct(
                        isSelected: selectedCategory == data[index].name,
                        onPressed: () {
                          ref
                              .read(productsProvider.notifier)
                              .getCategoryProducts(category: data[index].name);
                          ref.read(selectedCategoryProvider.notifier).state =
                              data[index].name;
                        },
                        data: data[index].name,
                      ),
                    ),
                  ),
                );
              },
            );
          },
          error: (error, stackTrace) => Center(
            child: Text(error.toString(), style: StyleManager.cardTitle),
          ),
          loading: () => _buildLoadingShimmer(),
        ),
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(width: 8.w),
      itemCount: 4,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: 100.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      ),
    );
  }
}
