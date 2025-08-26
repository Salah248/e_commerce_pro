import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuantityNotifier extends StateNotifier<int> {
  QuantityNotifier() : super(0);
}

final quantityProvider = StateNotifierProvider<QuantityNotifier, int>(
  (_) => QuantityNotifier(),
);
