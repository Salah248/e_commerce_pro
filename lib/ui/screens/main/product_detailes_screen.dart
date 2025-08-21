import 'package:e_commerce_pro/resources/color_manager.dart';
import 'package:e_commerce_pro/resources/style_manager.dart';
import 'package:e_commerce_pro/ui/widgets/custom_button.dart';
import 'package:e_commerce_pro/ui/widgets/custom_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
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
                  '\$ ${NumberFormat('#,##0').format(int.tryParse('1935') ?? 0)}',
                  style: StyleManager.headingTitle.copyWith(fontSize: 24.sp),
                ),
              ],
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: CustomButton(
                buttonTitle: 'Add to Cart',
                onPressed: () {},
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
      ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomCachedNetworkImage(
              imageUrl: 'https://picsum.photos/200/300',
              width: 341.w,
              height: 358.h,
            ),
            SizedBox(height: 12.h),
            Text('Fit Polo T Shirt', style: StyleManager.cardTitle),
            SizedBox(height: 12.h),
            Row(
              children: [
                const Icon(Icons.star_rate_rounded, color: Colors.amber),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '4.0/5',
                        style: StyleManager.textFieldTitle.copyWith(
                          fontSize: 16.sp,
                          decoration: TextDecoration.underline,
                          decorationColor: ColorManager.primaryDarkColor,
                        ),
                      ),
                      TextSpan(
                        text: ' (45 reviews)',
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
              'Blue T Shirt . Good for All Men and Suits for All of Them.Blue T Shirt . Good for All Men and Suits for All of Them',
              style: StyleManager.cardSubTitle,
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}
