import 'package:e_commerce_pro/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class StyleManager {
  static final TextStyle headingTitle = GoogleFonts.readexPro(
    color: ColorManager.primaryDarkColor,
    fontSize: 32.sp,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle headingSubTitle = GoogleFonts.readexPro(
    color: ColorManager.secondaryColor,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle textFieldTitle = GoogleFonts.readexPro(
    color: ColorManager.primaryDarkColor,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle textFieldHint = GoogleFonts.readexPro(
    color: ColorManager.secondaryColor,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle buttonTitle = GoogleFonts.dmSans(
    color: ColorManager.whiteColor,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle cardTitle = GoogleFonts.dmSans(
    color: ColorManager.primaryDarkColor,
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle cardSubTitle = GoogleFonts.dmSans(
    color: ColorManager.secondaryColor,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );
}
