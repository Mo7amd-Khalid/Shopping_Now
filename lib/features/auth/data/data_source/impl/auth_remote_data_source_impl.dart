import 'package:injectable/injectable.dart';
import 'package:route_e_commerce_v2/features/auth/data/models/login_request_dto.dart';
import 'package:route_e_commerce_v2/core/utils/app_exeptions.dart';
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
      return Success(response);
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
      return Success(response);
    });
  }
}