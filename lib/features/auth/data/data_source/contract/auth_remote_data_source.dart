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

}