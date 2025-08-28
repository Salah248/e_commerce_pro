import 'package:e_commerce_pro/core/di.dart';
import 'package:e_commerce_pro/core/model/token_model.dart';
import 'package:e_commerce_pro/core/services/repo/repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginNotifier extends AsyncNotifier<TokenModel?> {
  @override
  Future<TokenModel?> build() async {
    // Initial state (null => no user logged in)
    return null;
  }

  Future<void> login(String username, String password) async {
    state = const AsyncLoading();
    final result = await di<AuthRepository>().postLogin({
      'username': username,
      'password': password,
    });
    state = result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (token) => AsyncData(token),
    );
  }
}

final loginProvider = AsyncNotifierProvider<LoginNotifier, TokenModel?>(() {
  return LoginNotifier();
});
