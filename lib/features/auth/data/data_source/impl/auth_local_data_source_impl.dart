import 'package:E_Commerce/core/constants/app_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:E_Commerce/features/auth/data/data_source/contract/auth_local_data_source.dart';
import 'package:E_Commerce/network/results.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../network/safe_call.dart';

@Injectable(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource{

  SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> saveToken(String token) async{
    safeCall(()async{
      await sharedPreferences.setString(AppConstants.token, token);
      return Success(data: null);
    });
  }

  @override
  Future<void> removeToken() async{
    safeCall(()async{
      await sharedPreferences.remove(AppConstants.token);
      return Success(data: null);
    });

  }

}