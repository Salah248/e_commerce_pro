import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuantityNotifier extends StateNotifier<int> {
  QuantityNotifier() : super(0);

  void increment() {
    state++;
  }

  void decrement() {
    state--;
  }
}

final quantityProvider = StateNotifierProvider<QuantityNotifier, int>(
  (_) => QuantityNotifier(),
);
