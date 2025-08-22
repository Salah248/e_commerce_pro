import 'package:e_commerce_pro/data/services/secure_storge.dart';
import 'package:e_commerce_pro/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../resources/route_manager.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // يتم تنفيذ التوجيه بعد بناء الشاشة مباشرة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLogin(context);
    });

    return Container(
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
      color: Colors.white,
      child: Lottie.asset(
        'assets/animation/loading.json',
        fit: BoxFit.cover,
        repeat: true,
        reverse: true,
        animate: true,
        height: 200,
        width: 200,
      ),
    );
  }

  Future<void> _checkLogin(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2)); // لتأخير الانتقال قليلاً
    final token = await di<SecureStorage>().get('token');
    if (token != null && token.isNotEmpty && token != 'null') {
      context.go(Routes.main);
    } else {
      context.go(Routes.login);
    }
  }
}
