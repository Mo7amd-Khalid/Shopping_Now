import 'package:E_Commerce/features/auth/data/models/auth_response_dto.dart';
import 'package:E_Commerce/features/auth/data/models/forget_password_response.dart';
import 'package:E_Commerce/features/auth/data/models/user_data_dto.dart';

import '../../../../network/results.dart';

abstract interface class AuthRepo {

  Future<Results<String>> signUp({
    required String name,
    required String email,
    required String password,
    required String rePassword,
  });

  Future<Results<AuthResponseDto>> login({
    required String email,
    required String password,
});

  Future<void> logout();

  Future<Results<ForgetPasswordResponse>> sendEmailToCheckIn({
    required String email,
});

  Future<Results<ForgetPasswordResponse>> verifySentCode({required String code});

  Future<Results<ForgetPasswordResponse>> resetPassword({required String email, required String newPassword});

  Future<Results<UserDataDto>> getUserData();
}