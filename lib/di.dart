import 'package:e_commerce_pro/data/services/dio_servecis.dart';
import 'package:e_commerce_pro/data/services/secure_storge.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;

void initDi() {
  di.registerSingleton<DioService>(DioService());
  di.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  di.registerSingleton<SecureStorage>(SecureStorage());
}
