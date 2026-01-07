import 'package:injectable/injectable.dart';
import 'package:route_e_commerce_v2/features/auth/data/data_source/contract/auth_local_data_source.dart';
import 'package:route_e_commerce_v2/network/results.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../network/safe_call.dart';

@Injectable(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource{

  SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> saveToken(String token) async{
    safeCall(()async{
      await sharedPreferences.setString("token", token);
      return Success(data: null);
    });
  }

}