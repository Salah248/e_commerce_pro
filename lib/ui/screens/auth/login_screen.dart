import 'package:e_commerce_pro/resources/color_manager.dart';
import 'package:e_commerce_pro/resources/route_manager.dart';
import 'package:e_commerce_pro/ui/widgets/custom_app_bar.dart';
import 'package:e_commerce_pro/ui/widgets/custom_button.dart';
import 'package:e_commerce_pro/ui/widgets/custom_text_from_field.dart';
import 'package:e_commerce_pro/ui/widgets/custom_text_span.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var obscure = true;
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
                const CustomAppBar(
                  title: 'Login to your account',
                  supTitle: 'It’s great to see you again.',
                ),
                SizedBox(height: 24.h),
                CustomTextFormField(
                  controller: _emailController,
                  titleText: 'User Name',
                  hintText: 'email address',
                ),
                SizedBox(height: 16.h),
                CustomTextFormField(
                  controller: _passwordController,
                  titleText: 'Password',
                  hintText: 'password',
                  obscureText: obscure,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                    icon: Icon(
                      obscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: ColorManager.secondaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 55.h),
                CustomButton(
                  buttonTitle: 'Sign In',
                  onPressed: () {
                    context.pushReplacement(Routes.main);
                  },
                ),
                SizedBox(height: 260.h),
                CustomTextSpan(
                  text: 'Don’t have an account?',
                  textInline: 'Join',
                  onTap: () => context.push(Routes.signUp),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
