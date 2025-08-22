import 'package:e_commerce_pro/data/services/secure_storge.dart';
import 'package:e_commerce_pro/di.dart';
import 'package:e_commerce_pro/resources/color_manager.dart';
import 'package:e_commerce_pro/resources/route_manager.dart';
import 'package:e_commerce_pro/resources/style_manager.dart';
import 'package:e_commerce_pro/ui/widgets/custom_button.dart';
import 'package:e_commerce_pro/ui/widgets/show_snak_par.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.h),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  Center(
                    child: Text(
                      'Account',
                      style: StyleManager.headingTitle.copyWith(
                        fontSize: 24.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  const Divider(color: ColorManager.borderColor, thickness: 1),
                  SizedBox(height: 21.h),
                  _customItem(
                    iconImage: 'assets/icons/Box.png',
                    title: 'My Orders',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            const Divider(
              color: ColorManager.secondaryColor,
              thickness: 8,
              height: 0,
              indent: 0,
              endIndent: 0,
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.h),
              child: Column(
                children: [
                  _customItem(
                    iconImage: 'assets/icons/Details.png',
                    title: 'My Details',
                    onTap: () {},
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40.w),
                    child: const Divider(
                      color: ColorManager.borderColor,
                      thickness: 1,
                    ),
                  ),
                  _customItem(
                    iconImage: 'assets/icons/Address.png',
                    title: 'Address Book',
                    onTap: () => context.push(Routes.address),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40.w),
                    child: const Divider(
                      color: ColorManager.borderColor,
                      thickness: 1,
                    ),
                  ),
                  _customItem(
                    iconImage: 'assets/icons/Question.png',
                    title: 'FAQs',
                    onTap: () {},
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40.w),
                    child: const Divider(
                      color: ColorManager.borderColor,
                      thickness: 1,
                    ),
                  ),
                  _customItem(
                    iconImage: 'assets/icons/Headphones.png',
                    title: 'Help Center',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            const Divider(
              color: ColorManager.borderColor,
              thickness: 8,
              height: 0,
              indent: 0,
              endIndent: 0,
            ),
            SizedBox(height: 24.h),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                icon: Image.asset(
                  'assets/icons/Logout.png',
                  color: ColorManager.redColor,
                  width: 24.h,
                  height: 24.w,
                  fit: BoxFit.contain,
                ),
                onPressed: () {
                  _showDialog();
                },
                label: Text(
                  'Logout',
                  style: StyleManager.headingSubTitle.copyWith(
                    color: ColorManager.redColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customItem({String? iconImage, String? title, VoidCallback? onTap}) {
    return Row(
      children: [
        Image.asset(
          iconImage ?? '',
          width: 24.w,
          height: 24.h,
          fit: BoxFit.fill,
        ),
        SizedBox(width: 16.w),
        Text(
          title ?? 'no title',
          style: StyleManager.headingSubTitle.copyWith(
            color: ColorManager.primaryDarkColor,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: onTap,
          style: IconButton.styleFrom(
            padding: EdgeInsets.zero,
            iconSize: 24.sp,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          icon: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: ColorManager.secondaryColor,
          ),
        ),
      ],
    );
  }

  void _showDialog() {
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return AlertDialog(
          alignment: Alignment.center,
          elevation: 0,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          contentPadding: EdgeInsets.symmetric(
            vertical: 24.h,
            horizontal: 16.w,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/icons/Warning.png', fit: BoxFit.contain),
              SizedBox(height: 16.h),
              Text(
                'Logout?',
                style: StyleManager.headingTitle.copyWith(fontSize: 20.sp),
              ),
              SizedBox(height: 8.h),
              Text(
                'Are you sure you want to logout?',
                style: StyleManager.headingSubTitle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              CustomButton(
                buttonTitle: 'Yes, Logout',
                backgroundColor: ColorManager.redColor,
                onPressed: () async {
                  context.pop();
                  await di<SecureStorage>().delete('token');
                  showSnackBar(context, 'Logout successfully');
                  context.go(Routes.login);
                },
                width: 293.w,
                height: 54.h,
              ),
              SizedBox(height: 12.h),
              CustomButton(
                buttonTitle: 'No, Cancel',
                backgroundColor: Colors.white,
                textColor: ColorManager.primaryDarkColor,
                bordarColor: ColorManager.borderColor,
                onPressed: () => context.pop(),
                width: 293.w,
                height: 54.h,
              ),
            ],
          ),
        );
      },
    );
  }
}
