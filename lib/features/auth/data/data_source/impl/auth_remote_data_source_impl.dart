import 'package:injectable/injectable.dart';
import 'package:route_e_commerce_v2/features/auth/data/models/forget_password_response.dart';
import 'package:route_e_commerce_v2/features/auth/data/models/login_request_dto.dart';
import 'package:route_e_commerce_v2/core/utils/app_exeptions.dart';
import 'package:route_e_commerce_v2/features/auth/data/models/reset_password_request.dart';
import 'package:route_e_commerce_v2/features/auth/data/models/send_email_to_check.dart';
import 'package:route_e_commerce_v2/features/auth/data/models/verify_code_request.dart';
import 'package:route_e_commerce_v2/network/results.dart';
import 'package:route_e_commerce_v2/network/safe_call.dart';
import 'package:route_e_commerce_v2/features/auth/data/data_source/contract/auth_remote_data_source.dart';
import 'package:route_e_commerce_v2/features/auth/data/models/auth_response_dto.dart';
import 'package:route_e_commerce_v2/network/api_client.dart';

import '../../models/register_request_dto.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{

  final ApiClient apiClient;

  AuthRemoteDataSourceImpl(this.apiClient);


  @override
  Future<Results<AuthResponseDto>> signUp({
    required String name,
    required String email,
    required String password,
    required String rePassword,
})async{
    return safeCall(() async{
      var request = RegisterRequestDto(
        name: name,
        email: email,
        password: password,
        rePassword: rePassword,
      );
      var response = await apiClient.signUp(request);
      if(response.statusMsg != null) {
        return Failure(AuthException(), response.message ?? "");
      }
      return Success(data: response);
    });
  }

  @override
  Future<Results<AuthResponseDto>> login({required String email, required String password}) async{
    return safeCall(()async{
      LoginRequestDto request = LoginRequestDto(email: email, password: password);
      var response = await apiClient.signIn(request);
      if(response.statusMsg != null)
        {
          return Failure(AuthException(), response.message??"");
        }
      return Success(data: response);
    });
  }

  @override
  Future<Results<ForgetPasswordResponse>> sendEmailToCheckIn({required String email}) async{
    return safeCall(()async{
      SendEmailToCheckRequest request = SendEmailToCheckRequest(email: email);
      var response = await apiClient.sendEmailToCheckIn(request);
      if(response.statusMsg == "fail")
        {
          return Failure(AuthException(), response.message ?? "");
        }

      return Success(data: response);
    });
  }

  @override
  Future<Results<ForgetPasswordResponse>> verifySentCode({required String code}) async{
    return safeCall(()async{
      VerifyCodeRequest request = VerifyCodeRequest(resetCode: code);

      var response = await apiClient.verifySentCode(request);
      if(response.statusMsg!= null)
        {
          return Failure(AuthException(), response.message ?? "");
        }

      return Success(data: response);
    });


  }

  @override
  Future<Results<ForgetPasswordResponse>> resetPassword({required String email, required String newPassword}) async{
    return safeCall(()async{
      ResetPasswordRequest request = ResetPasswordRequest(
        email: email,
        newPassword: newPassword,
      );

      var response = await apiClient.resetPassword(request);
      if(response.statusMsg != null)
        {
          return Failure(AuthException(), response.message ?? "");
        }

      return Success(data: response);
    });
  }
}