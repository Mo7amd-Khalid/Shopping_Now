import 'package:route_e_commerce_v2/features/auth/data/models/auth_response_dto.dart';

import '../../../../network/results.dart';

abstract interface class AuthRepo {

  Future<Results<String>> signUp({
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