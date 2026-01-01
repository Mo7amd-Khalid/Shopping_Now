import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:route_e_commerce_v2/core/constants/app_constants.dart';
import 'package:route_e_commerce_v2/core/di/di.dart';
import 'package:route_e_commerce_v2/features/auth/data/data_source/contract/auth_local_data_source.dart';
import 'package:route_e_commerce_v2/features/auth/data/models/forget_password_response.dart';
import 'package:route_e_commerce_v2/network/results.dart';
import 'package:route_e_commerce_v2/features/auth/data/models/auth_response_dto.dart';
import 'package:route_e_commerce_v2/features/auth/domain/repository/auth_repo.dart';
import '../data_source/contract/auth_remote_data_source.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepoImpl(this.authRemoteDataSource, this.authLocalDataSource);

  @override
  Future<Results<String>> signUp({
    required String name,
    required String email,
    required String password,
    required String rePassword,
  }) async {
    var response = await authRemoteDataSource.signUp(
      name: name,
      email: email,
      password: password,
      rePassword: rePassword,
    );
    return switch (response) {
      Success<AuthResponseDto>() => Success(response.data!.token),
      Failure<AuthResponseDto>() => Failure(
        response.exception,
        response.errorMessage,
      ),
    };
  }

  @override
  Future<Results<AuthResponseDto>> login({
    required String email,
    required String password,
  }) async {
    var response = await authRemoteDataSource.login(
      email: email,
      password: password,
    );
    switch (response) {
      case Success<AuthResponseDto>():
        {
          authLocalDataSource.saveToken(response.data!.token!);
          getIt<Dio>().options.headers[AppConstants.token] =
              response.data!.token!;
          return Success(response.data);
        }
      case Failure<AuthResponseDto>():
        {
          return Failure(response.exception, response.errorMessage);
        }
    }
  }

  @override
  Future<Results<ForgetPasswordResponse>> sendEmailToCheckIn({
    required String email,
  }) async {
    var response = await authRemoteDataSource.sendEmailToCheckIn(email: email);

    switch (response) {
      case Success<ForgetPasswordResponse>():
        return Success(response.data);
      case Failure<ForgetPasswordResponse>():
        return Failure(response.exception, response.errorMessage);
    }
  }

  @override
  Future<Results<ForgetPasswordResponse>> verifySentCode({
    required String code,
  }) async {
    var response = await authRemoteDataSource.verifySentCode(code: code);

    return switch (response) {
      Success<ForgetPasswordResponse>() => Success(response.data),
      Failure<ForgetPasswordResponse>() => Failure(
        response.exception,
        response.errorMessage,
      ),
    };
  }

  @override
  Future<Results<ForgetPasswordResponse>> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    var response = await authRemoteDataSource.resetPassword(
      email: email,
      newPassword: newPassword,
    );

    return switch (response) {
      Success<ForgetPasswordResponse>() => Success(response.data),

      Failure<ForgetPasswordResponse>() => Failure(
        response.exception,
        response.errorMessage,
      ),
    };
  }
}
