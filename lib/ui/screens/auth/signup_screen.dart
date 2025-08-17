import 'package:e_commerce_pro/resources/color_manager.dart';
import 'package:e_commerce_pro/resources/route_manager.dart';
import 'package:e_commerce_pro/ui/widgets/custom_app_bar.dart';
import 'package:e_commerce_pro/ui/widgets/custom_button.dart';
import 'package:e_commerce_pro/ui/widgets/custom_text_from_field.dart';
import 'package:e_commerce_pro/ui/widgets/custom_text_span.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: const CustomAppBar(
                    title: 'Create an account',
                    supTitle: 'Let’s create your account.',
                  ),
                ),
                SizedBox(height: 24.h),
                const CustomTextFormField(
                  titleText: 'Full Name',
                  hintText: 'full name',
                ),
                SizedBox(height: 16.h),
                const CustomTextFormField(
                  titleText: 'User Name',
                  hintText: 'email address',
                ),
                SizedBox(height: 16.h),
                CustomTextFormField(
                  titleText: 'Password',
                  hintText: 'password',
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.visibility_off_outlined,
                      color: ColorManager.secondaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                CustomTextFormField(
                  titleText: 'Confirm Password',
                  hintText: 'confirm password',
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.visibility_off_outlined,
                      color: ColorManager.secondaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 55.h),
                CustomButton(buttonTitle: 'Create Account', onPressed: () {}),
                SizedBox(height: 60.h),
                CustomTextSpan(
                  text: 'Already have an account?',
                  textInline: 'Log In',
                  onTap: () => context.pop(Routes.login),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
