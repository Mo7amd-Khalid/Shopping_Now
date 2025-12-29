import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:route_e_commerce_v2/features/auth/data/models/auth_response_dto.dart';
import 'package:route_e_commerce_v2/features/auth/data/models/login_request_dto.dart';
import '../core/constants/api_constants.dart';
import '../features/auth/data/models/register_request_dto.dart';

part 'api_client.g.dart';

@singleton
@RestApi()
abstract class ApiClient {

  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;


  @POST(ApiConstants.signUp)
  Future<AuthResponseDto> signUp(@Body() RegisterRequestDto request);

  @POST(ApiConstants.signIn)
  Future<AuthResponseDto> signIn(@Body() LoginRequestDto request);

}