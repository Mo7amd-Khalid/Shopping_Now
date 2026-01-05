import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:route_e_commerce_v2/features/auth/data/models/auth_response_dto.dart';
import 'package:route_e_commerce_v2/features/auth/data/models/forget_password_response.dart';
import 'package:route_e_commerce_v2/features/auth/data/models/login_request_dto.dart';
import 'package:route_e_commerce_v2/features/auth/data/models/reset_password_request.dart';
import 'package:route_e_commerce_v2/features/auth/data/models/send_email_to_check.dart';
import 'package:route_e_commerce_v2/features/auth/data/models/verify_code_request.dart';
import 'package:route_e_commerce_v2/features/commerce/data/models/category_models/categories_response_dto.dart';
import 'package:route_e_commerce_v2/features/commerce/data/models/product_list_model/pageable_product_response_dto.dart';
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

  @POST(ApiConstants.forgetPassword)
  Future<ForgetPasswordResponse> sendEmailToCheckIn(@Body() SendEmailToCheckRequest request);

  @POST(ApiConstants.verifyRestCode)
  Future<ForgetPasswordResponse> verifySentCode (@Body() VerifyCodeRequest request);
  
  @PUT(ApiConstants.resetPassword)
  Future<ForgetPasswordResponse> resetPassword(@Body() ResetPasswordRequest request);

  @GET(ApiConstants.getAllCategories)
  Future<CategoriesResponseDto> getCategories();

  @GET("/api/v1/categories/{categoryId}}/subcategories")
  Future<CategoriesResponseDto> getSubCategory(@Path("categoryId") String categoryId);

  @GET(ApiConstants.getAllProducts)
  Future<PageableProductResponseDto> getProductList(@Query("category[in]") String categoryId, @Query("page") int page, {@Query("limit") int limit = 10});

}