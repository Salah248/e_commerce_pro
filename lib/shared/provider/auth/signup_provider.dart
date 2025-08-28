import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:e_commerce_pro/core/di.dart';
import 'package:e_commerce_pro/core/services/repo/repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpProviderNotifier extends StateNotifier<Map<String, dynamic>> {
  SignUpProviderNotifier() : super({});

  Future<Either> postSignUp(Map<String, dynamic> data) async {
    log('postSignUp : in provider');
    try {
      final response = await di<AuthRepository>().postSignup(data);
      return Right(response);
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }
}

final signUpProvider =
    StateNotifierProvider<SignUpProviderNotifier, Map<String, dynamic>>(
      (ref) => SignUpProviderNotifier(),
    );
