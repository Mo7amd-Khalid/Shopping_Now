import 'package:E_Commerce/features/auth/data/models/user_data_dto.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:E_Commerce/core/constants/app_constants.dart';
import 'package:E_Commerce/core/di/di.dart';
import 'package:E_Commerce/features/auth/data/data_source/contract/auth_local_data_source.dart';
import 'package:E_Commerce/features/auth/data/models/forget_password_response.dart';
import 'package:E_Commerce/network/results.dart';
import 'package:E_Commerce/features/auth/data/models/auth_response_dto.dart';
import 'package:E_Commerce/features/auth/domain/repository/auth_repo.dart';
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
      Success<AuthResponseDto>() => Success(data: response.data!.token),
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
          return Success(data: response.data);
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
        return Success(data: response.data);
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
      Success<ForgetPasswordResponse>() => Success(data: response.data),
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
      Success<ForgetPasswordResponse>() => Success(data: response.data),

      Failure<ForgetPasswordResponse>() => Failure(
        response.exception,
        response.errorMessage,
      ),
    };
  }

  @override
  Future<void> logout() async{
    await authLocalDataSource.removeToken();
  }

  @override
  Future<Results<UserDataDto>> getUserData() async{
    var response = await authRemoteDataSource.getUserData();
    switch (response) {

      case Success<UserDataDto>():
        return Success(data: response.data);
      case Failure<UserDataDto>():
        return Failure(response.exception, response.errorMessage);
    }
  }
}
