import 'package:injectable/injectable.dart';
import 'package:E_Commerce/features/auth/data/models/forget_password_response.dart';
import 'package:E_Commerce/features/auth/domain/repository/auth_repo.dart';
import 'package:E_Commerce/network/results.dart';

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