import 'package:e_commerce_pro/core/services/secure_storge.dart';
import 'package:e_commerce_pro/core/di.dart';
import 'package:e_commerce_pro/shared/provider/auth/auth_provider.dart';
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

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var obscure = true;

  @override
  Widget build(BuildContext context) {
    ref.listen(authNotifierProvider, (previous, next) {
      next.whenOrNull(
        error: (err, _) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showSnackBar(context, err.toString());
          });
        },
        data: (data) {
          if (data != null) {
            di<SecureStorage>().set('token', data.token ?? '');
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showSnackBar(context, 'Login successfully');
              context.go(Routes.main);
            });
          }
        },
      );
    });
    final authState = ref.watch(authNotifierProvider);
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
                  const CustomAppBar(
                    title: 'Login to your account',
                    supTitle: 'It’s great to see you again.',
                  ),
                  SizedBox(height: 24.h),
                  CustomTextFormField(
                    controller: _userNameController,
                    titleText: 'User Name',
                    hintText: 'email address',
                    validator: (value) {
                      if (value!.isEmpty || value.length < 2) {
                        return 'Please enter a valid User Name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  CustomTextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return 'Please enter a valid password';
                      }
                      return null;
                    },
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
                  authState.when(
                    loading: () => const CircularProgressIndicator(),
                    data: (_) => CustomButton(
                      buttonTitle: 'Sign In',
                      onPressed: () => _signIn(),
                    ),
                    error: (error, _) => CustomButton(
                      buttonTitle: 'Retry',
                      onPressed: () => _signIn(),
                    ),
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
      ),
    );
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      ref
          .read(authNotifierProvider.notifier)
          .login(_userNameController.text, _passwordController.text)
          .then((_) {
            final authState = ref.read(authNotifierProvider);
            if (authState is AsyncData && authState.value != null) {
              di<SecureStorage>().set('token', authState.value?.token ?? '');
              showSnackBar(context, 'Login successfully');
              context.go(Routes.main);
            }
          });
    } else {
      showSnackBar(context, 'Please fill all fields');
    }
  }
}
