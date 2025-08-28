import 'package:e_commerce_pro/core/theme/style_manager.dart';
import 'package:e_commerce_pro/ui/main/Pages/home/widgets/custom_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../shared/provider/main/home/products_provider.dart';

class ProductsGrid extends ConsumerWidget {
  const ProductsGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsState = ref.watch(productsProvider);

    return AnimationLimiter(
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
                      child: CustomProduct(
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
          child: Text(error.toString(), style: StyleManager.cardTitle),
        ),
        loading: () => _buildLoadingShimmer(),
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 6,
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
    );
  }
}
