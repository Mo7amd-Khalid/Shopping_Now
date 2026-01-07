import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:route_e_commerce_v2/core/constants/app_constants.dart';
import 'package:route_e_commerce_v2/core/di/di.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_constants.dart';

@module
abstract class DioModule{

  @lazySingleton
  Dio provideDio(){
    Dio dio = Dio();
    SharedPreferences preferences = getIt();
    String? token = preferences.getString(AppConstants.token);
    Map<String, dynamic> headers = {};
    if(token != null){
      headers[AppConstants.token] = token;
    }
    dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      receiveTimeout: const Duration(seconds: 120),
      sendTimeout: const Duration(seconds: 120),
      connectTimeout: const Duration(seconds: 120),
      validateStatus: (state){
        return true;
      },
      headers: headers,
    );
    dio.interceptors.add(PrettyDioLogger(
      request: true,
      requestHeader:true,
      requestBody:true,
      responseHeader:true,
      responseBody:true,
      error:true,
      maxWidth:100,
      compact:true,
      enabled:kDebugMode,
    ));
    return dio;
  }

}