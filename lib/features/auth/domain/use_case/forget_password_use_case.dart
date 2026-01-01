import 'package:injectable/injectable.dart';
import 'package:route_e_commerce_v2/features/auth/data/models/forget_password_response.dart';
import 'package:route_e_commerce_v2/features/auth/domain/repository/auth_repo.dart';
import 'package:route_e_commerce_v2/network/results.dart';

@injectable
class ForgetPasswordUseCase {

  AuthRepo authRepo;

  ForgetPasswordUseCase(this.authRepo);

  Future<Results<ForgetPasswordResponse>> sendEmailToCheckIn(String email){
    return authRepo.sendEmailToCheckIn(email:email);
  }

  Future<Results<ForgetPasswordResponse>> verifySentCode(String code){
    return authRepo.verifySentCode(code: code);
  }

  Future<Results<ForgetPasswordResponse>> resetPassword({required String email, required String newPassword}) async {

    return authRepo.resetPassword(email: email, newPassword: newPassword);
  }

}