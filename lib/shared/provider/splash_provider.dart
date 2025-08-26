import 'package:e_commerce_pro/core/di.dart';
import 'package:e_commerce_pro/core/services/secure_storge.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashProvider = FutureProvider<bool>((ref) async {
  final token = await di<SecureStorage>().get('token');
  await Future.delayed(const Duration(seconds: 2));

  if (token != null && token.isNotEmpty && token != 'null') {
    return true;
  } else {
    return false;
  }
});
