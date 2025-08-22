import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashProvider extends StateNotifier<bool> {
  SplashProvider() : super(false);
  void setSplashState(bool value) {
    state = value;
  }
}

final splashProvider = StateNotifierProvider<SplashProvider, bool>((ref) {
  return SplashProvider();
});
