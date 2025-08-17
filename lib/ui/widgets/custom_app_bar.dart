import 'package:e_commerce_pro/resources/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title, required this.supTitle});
  final String title;
  final String supTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: StyleManager.headingTitle),
        SizedBox(height: 8.h),
        Text(supTitle, style: StyleManager.headingSubTitle),
      ],
    );
  }
}
