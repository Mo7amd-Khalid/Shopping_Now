import 'package:injectable/injectable.dart';
import 'package:E_Commerce/network/results.dart';
import 'package:E_Commerce/features/auth/data/models/auth_response_dto.dart';
import 'package:E_Commerce/features/auth/domain/repository/auth_repo.dart';

@injectable
class AuthUseCase {
  final AuthRepo authRepo;
  AuthUseCase(this.authRepo);


  Future<Results<String>> signUp({
    required String name,
    required String email,
    required String password,
    required String rePassword,
  })async{
    return authRepo.signUp(
        name: name,
        email: email,
        password: password,
        rePassword: rePassword);
  }

  Future<Results<AuthResponseDto>> login({
    required String email,
    required String password,
})async{
    return authRepo.login(email: email, password: password);
  }
}