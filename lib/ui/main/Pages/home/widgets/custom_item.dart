import 'package:e_commerce_pro/core/routes/route_manager.dart';
import 'package:e_commerce_pro/core/theme/style_manager.dart';
import 'package:e_commerce_pro/shared/widgets/custom_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CustomProduct extends StatelessWidget {
  const CustomProduct({
    super.key,
    this.image,
    this.title,
    this.price,
    this.extra,
  });
  final String? image;
  final String? title;
  final double? price;
  final Object? extra;
  @override
  Widget build(BuildContext context) {
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
}
