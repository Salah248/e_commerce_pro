import 'package:e_commerce_pro/core/model/products_model.dart';
import 'package:e_commerce_pro/ui/auth/login_screen.dart';
import 'package:e_commerce_pro/ui/auth/signup_screen.dart';
import 'package:e_commerce_pro/ui/main/adress_screen.dart';
import 'package:e_commerce_pro/ui/main/main_screen.dart';
import 'package:e_commerce_pro/ui/main/product_detailes_screen.dart';
import 'package:e_commerce_pro/ui/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:go_transitions/go_transitions.dart';

class Routes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String main = '/main';
  static const String productDetails = '/productDetails';
  static const String address = '/address';
}

class RouteManager {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.login,
        pageBuilder: GoTransitions.fadeUpwards.call,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: Routes.signUp,
        pageBuilder: GoTransitions.fadeUpwards.call,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: Routes.main,
        pageBuilder: GoTransitions.fadeUpwards.call,
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: Routes.productDetails,
        pageBuilder: GoTransitions.fadeUpwards.call,
        builder: (context, state) {
          return ProductDetailsScreen(
            productsModel: state.extra as ProductsModel,
          );
        },
      ),
      GoRoute(
        path: Routes.address,
        pageBuilder: GoTransitions.fadeUpwards.call,
        builder: (context, state) => const AdressScreen(),
      ),
    ],
  );
}
