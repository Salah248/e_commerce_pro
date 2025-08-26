import 'package:e_commerce_pro/shared/provider/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../core/routes/route_manager.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<bool>>(splashProvider, (_, state) {
      state.whenData((isLoggedIn) {
        if (isLoggedIn) {
          context.go(Routes.main);
        } else {
          context.go(Routes.login);
        }
      });
    });

    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: Lottie.asset(
        'assets/animation/loading.json',
        height: 200,
        width: 200,
      ),
    );
  }
}
