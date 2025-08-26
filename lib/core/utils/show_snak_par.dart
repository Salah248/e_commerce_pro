import 'package:e_commerce_pro/core/theme/color_manager.dart';
import 'package:e_commerce_pro/core/theme/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: StyleManager.textFieldTitle.copyWith(
          color: ColorManager.primaryColor,
        ),
      ),
      backgroundColor: ColorManager.borderColor,
      behavior: SnackBarBehavior.floating,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      margin: EdgeInsets.all(16.h),
      duration: const Duration(seconds: 2),
    ),
  );
}
