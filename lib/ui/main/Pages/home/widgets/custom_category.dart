import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/color_manager.dart';
import '../../../../../core/theme/style_manager.dart';

class CustomCategoryOfProduct extends StatelessWidget {
  const CustomCategoryOfProduct({
    super.key,
    this.data,
    required this.isSelected,
    this.onPressed,
  });
  final String? data;
  final bool isSelected;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
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
      onPressed: onPressed,
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
}
