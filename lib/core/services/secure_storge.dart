import 'dart:developer';

import 'package:e_commerce_pro/core/di.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = di<FlutterSecureStorage>();
  Future<String?> get(String key) async {
    log('geted');
    return await storage.read(key: key);
  }

  Future<void> set(String key, String value) async {
    log('seted');
    await storage.write(key: key, value: value);
  }

  Future<void> delete() async {
    log('delete');
    await storage.deleteAll();
  }
}
