import 'package:e_commerce_pro/core/theme/color_manager.dart';
import 'package:e_commerce_pro/core/theme/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    required this.buttonTitle,
    this.icon,
    this.width,
    this.height,
    this.fontSize,
    this.iconAlignment,
    this.backgroundColor,
    this.textColor,
    this.bordarColor,
    this.isLoading = false,
  });
  final void Function()? onPressed;
  final String buttonTitle;
  final Widget? icon;
  final double? width;
  final double? height;
  final double? fontSize;
  final IconAlignment? iconAlignment;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? bordarColor;
  final bool? isLoading;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width ?? 325.w, height ?? 50.h),
        backgroundColor: backgroundColor ?? ColorManager.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
          side: BorderSide(color: bordarColor ?? Colors.transparent),
        ),
      ),
      onPressed: onPressed,
      child: isLoading!
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : Row(
              mainAxisAlignment: iconAlignment == IconAlignment.end
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (iconAlignment != IconAlignment.end && icon != null) icon!,
                SizedBox(width: 10.w),
                Text(
                  buttonTitle,
                  style: StyleManager.buttonTitle.copyWith(
                    fontSize: fontSize,
                    color: textColor ?? ColorManager.whiteColor,
                  ),
                ),
                SizedBox(width: 10.w),
                if (iconAlignment == IconAlignment.end && icon != null) icon!,
              ],
            ),
    );
  }
}
