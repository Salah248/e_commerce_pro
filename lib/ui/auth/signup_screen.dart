import 'package:e_commerce_pro/shared/provider/auth/signup_provider.dart';
import 'package:e_commerce_pro/core/theme/color_manager.dart';
import 'package:e_commerce_pro/core/routes/route_manager.dart';
import 'package:e_commerce_pro/shared/widgets/custom_app_bar.dart';
import 'package:e_commerce_pro/shared/widgets/custom_button.dart';
import 'package:e_commerce_pro/shared/widgets/custom_text_from_field.dart';
import 'package:e_commerce_pro/shared/widgets/custom_text_span.dart';
import 'package:e_commerce_pro/core/utils/show_snak_par.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _obscure = true;
  @override
  Widget build(BuildContext context) {
    final post = ref.read<SignUpProviderNotifier>(signUpProvider.notifier);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
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
                  CustomTextFormField(
                    titleText: 'Full Name',
                    hintText: 'full name',
                    controller: _nameController,
                  ),
                  SizedBox(height: 16.h),
                  CustomTextFormField(
                    titleText: 'Email',
                    hintText: 'email address',
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  CustomTextFormField(
                    titleText: 'Password',
                    hintText: 'password',
                    controller: _passwordController,
                    obscureText: _obscure,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscure = !_obscure;
                        });
                      },
                      icon: Icon(
                        _obscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: ColorManager.secondaryColor,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  CustomTextFormField(
                    titleText: 'Confirm Password',
                    hintText: 'confirm password',
                    obscureText: _obscure,
                    controller: _confirmPasswordController,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscure = !_obscure;
                        });
                      },
                      icon: Icon(
                        _obscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: ColorManager.secondaryColor,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 55.h),
                  CustomButton(
                    buttonTitle: 'Create Account',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        post
                            .postSignUp({
                              'username': _nameController.text,
                              'email': _emailController.text,
                              'password': _passwordController.text,
                            })
                            .then((_) {
                              if (context.mounted) {
                                context.pop();
                                showSnackBar(
                                  context,
                                  'Created Account Successfully',
                                );
                              }
                              return;
                            });
                      }
                    },
                  ),
                  SizedBox(height: 60.h),
                  CustomTextSpan(
                    text: 'Already have an account?',
                    textInline: 'Log In',
                    onTap: () => context.pop(Routes.login),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
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
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
