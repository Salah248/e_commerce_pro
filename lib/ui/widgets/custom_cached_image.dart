import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_pro/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.radius,
  });
  final String? imageUrl;
  final double? width;
  final double? height;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 10.r),
      ),
      child: CachedNetworkImage(
        width: width,
        height: height,
        imageUrl: (imageUrl == null || imageUrl!.isEmpty)
            ? 'https://static.thenounproject.com/png/504708-200.png'
            : imageUrl!,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) {
          log('error: $error');
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.image_not_supported, color: Colors.red),
              SizedBox(width: 10.w),
              Container(
                width: 100.w,
                height: 100.h,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://static.thenounproject.com/png/504708-200.png',
                    ),
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ],
          );
        },
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(color: ColorManager.primaryColor),
        ),
      ),
    );
  }
}
