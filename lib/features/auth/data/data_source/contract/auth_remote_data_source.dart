import 'package:route_e_commerce_v2/features/auth/data/models/forget_password_response.dart';
import 'package:route_e_commerce_v2/network/results.dart';
import 'package:route_e_commerce_v2/features/auth/data/models/auth_response_dto.dart';

abstract interface class AuthRemoteDataSource {

  Future<Results<AuthResponseDto>> signUp({
    required String name,
    required String email,
    required String password,
    required String rePassword,
  });

  Future<Results<AuthResponseDto>> login({
    required String email,
    required String password,
  });

  Future<Results<ForgetPasswordResponse>> sendEmailToCheckIn({
    required String email,
});

  Future<Results<ForgetPasswordResponse>> verifySentCode({
    required String code,
});

  Future<Results<ForgetPasswordResponse>> resetPassword({
    required String email,
    required String newPassword,
});
}