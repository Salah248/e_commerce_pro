import 'package:e_commerce_pro/data/services/secure_storge.dart';
import 'package:e_commerce_pro/di.dart';
import 'package:e_commerce_pro/provider/post_provider.dart';
import 'package:e_commerce_pro/resources/color_manager.dart';
import 'package:e_commerce_pro/resources/route_manager.dart';
import 'package:e_commerce_pro/ui/widgets/custom_app_bar.dart';
import 'package:e_commerce_pro/ui/widgets/custom_button.dart';
import 'package:e_commerce_pro/ui/widgets/custom_text_from_field.dart';
import 'package:e_commerce_pro/ui/widgets/custom_text_span.dart';
import 'package:e_commerce_pro/ui/widgets/show_snak_par.dart';
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
    final post = ref.read<PostProviderNotifier>(postProvider.notifier);
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
                  CustomButton(
                    buttonTitle: 'Sign In',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        post
                            .postLogin({
                              'username': _userNameController.text,
                              'password': _passwordController.text,
                            })
                            .then((value) {
                              if (value.isRight()) {
                                di<SecureStorage>().set(
                                  'token',
                                  value.fold((l) => '', (r) => r.token ?? ''),
                                );
                                showSnackBar(context, 'Login successfully');
                                context.go(Routes.main);
                              } else {
                                showSnackBar(
                                  context,
                                  value.fold((l) => l, (r) => r.token ?? ''),
                                );
                              }
                            });
                      } else {
                        showSnackBar(context, 'Please fill all fields');
                      }
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
      ),
    );
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
