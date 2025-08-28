import 'package:e_commerce_pro/core/model/products_model.dart';
import 'package:e_commerce_pro/shared/provider/main/cart/update_cart_provider.dart';
import 'package:e_commerce_pro/core/theme/color_manager.dart';
import 'package:e_commerce_pro/core/routes/route_manager.dart';
import 'package:e_commerce_pro/core/theme/style_manager.dart';
import 'package:e_commerce_pro/shared/widgets/custom_button.dart';
import 'package:e_commerce_pro/shared/widgets/custom_cached_image.dart';
import 'package:e_commerce_pro/core/utils/show_snak_par.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  const ProductDetailsScreen({super.key, required this.productsModel});
  final ProductsModel productsModel;

  @override
  ConsumerState<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: _bottomSheet(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Details',
          style: StyleManager.headingTitle.copyWith(fontSize: 24.sp),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.r),
        child: SingleChildScrollView(
          child: AnimationLimiter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 375),
                childAnimationBuilder: (widget) => SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(child: widget),
                ),
                children: [
                  Hero(
                    tag: widget.productsModel.image!,
                    child: CustomCachedNetworkImage(
                      fit: BoxFit.fitHeight,
                      imageUrl: widget.productsModel.image ?? '',
                      width: 341.w,
                      height: 358.h,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    widget.productsModel.title ?? 'Product Name',
                    style: StyleManager.cardTitle,
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      const Icon(Icons.star_rate_rounded, color: Colors.amber),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  '${widget.productsModel.rating?.rate ?? 0.0}',
                              style: StyleManager.textFieldTitle.copyWith(
                                fontSize: 16.sp,
                                decoration: TextDecoration.underline,
                                decorationColor: ColorManager.primaryDarkColor,
                              ),
                            ),
                            TextSpan(
                              text:
                                  ' (${widget.productsModel.rating?.count ?? 0} reviews)',
                              style: StyleManager.textFieldHint.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    widget.productsModel.description ?? 'Product Description',
                    style: StyleManager.cardSubTitle,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 140.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomSheet() {
    return Container(
      height: 105.h,
      clipBehavior: Clip.none,
      padding: EdgeInsets.symmetric(horizontal: 25.r, vertical: 15.r),
      margin: EdgeInsets.zero,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.zero,
        color: Colors.white,
        shape: BoxShape.rectangle,
        border: Border(
          top: BorderSide(color: ColorManager.borderColor, width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Price', style: StyleManager.headingSubTitle),
              Text(
                '\$ ${NumberFormat('0.00', 'en_US').format(widget.productsModel.price ?? 0)}',
                style: StyleManager.headingTitle.copyWith(fontSize: 24.sp),
              ),
            ],
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: CustomButton(
              buttonTitle: 'Add to Cart',
              isLoading: isLoading,
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });

                await ref
                    .read(updateCartProvider.notifier)
                    .addToCart(product: widget.productsModel, quantity: 1);

                setState(() {
                  isLoading = false;
                });

                showSnackBar(context, 'Product added to cart');
                context.go(Routes.main);
              },
              width: 240.w,
              height: 54.h,
              fontSize: 16.sp,
              icon: Icon(
                Icons.local_mall_outlined,
                color: ColorManager.whiteColor,
                size: 22.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
