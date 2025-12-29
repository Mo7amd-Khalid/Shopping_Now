import 'package:injectable/injectable.dart';
import 'package:route_e_commerce_v2/core/base/base_cubit.dart';
import 'package:route_e_commerce_v2/core/utils/resources.dart';
import 'package:route_e_commerce_v2/features/auth/data/models/auth_response_dto.dart';
import 'package:route_e_commerce_v2/features/auth/domain/use_case/auth_use_case.dart';
import 'package:route_e_commerce_v2/network/results.dart';

import 'login_state.dart';


@injectable
class LoginCubit extends BaseCubit<LoginState, LoginActions, LoginNavigation>{
  LoginCubit(this.authUseCase) : super(LoginState());
  AuthUseCase authUseCase;

  @override
  Future<void> doActions(LoginActions action) async{
    switch(action) {
      case NavigatorToRegisterAction():{
        _navigatorToRegisterScreen();
      }
      case LoginUserAction():{
        _login(action.email, action.password);

      }
    }
  }

  void _navigatorToRegisterScreen(){
    emitNavigation(GoToRegisterScreen());
  }

  Future<void> _login(String email, String password) async{
    emit(state.copyWith(const Resources.loading()));
    var response = await authUseCase.login(email: email, password: password);
    switch (response) {

      case Success<AuthResponseDto>():{
        emitNavigation(GoToHomeScreen("Login Done Successfully"));
        emit(state.copyWith(Resources.success(data: response.data)));
      }
      case Failure<AuthResponseDto>():{
        emitNavigation(ShowToastError(response.errorMessage));
        emit(state.copyWith(Resources.failure(exception: response.exception, message: response.errorMessage)));
      }
    }

  }
}