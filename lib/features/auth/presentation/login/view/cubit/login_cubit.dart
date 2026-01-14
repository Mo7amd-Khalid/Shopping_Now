import 'package:injectable/injectable.dart';
import 'package:E_Commerce/core/base/base_cubit.dart';
import 'package:E_Commerce/core/utils/resources.dart';
import 'package:E_Commerce/features/auth/data/models/auth_response_dto.dart';
import 'package:E_Commerce/features/auth/domain/use_case/auth_use_case.dart';
import 'package:E_Commerce/network/results.dart';

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
      case NavigatorToForgetPasswordAction():{
       _navigatorToForgetPasswordScreen();
      }
      case ChangeVisibility():{
        _changeVisibility();
      }
    }
  }

  void _navigatorToRegisterScreen(){
    emitNavigation(GoToRegisterScreen());
  }

  void _navigatorToForgetPasswordScreen(){
    emitNavigation(GoToForgetPasswordScreen());
  }
  Future<void> _login(String email, String password) async{
    emit(state.copyWith(loginResources:  const Resources.loading()));
    var response = await authUseCase.login(email: email, password: password);
    switch (response) {

      case Success<AuthResponseDto>():{
        emitNavigation(GoToHomeScreen("Login Done Successfully"));
        emit(state.copyWith(loginResources:  Resources.success(data: response.data)));
      }
      case Failure<AuthResponseDto>():{
        emitNavigation(ShowToastError(response.errorMessage));
        emit(state.copyWith(loginResources: Resources.failure(exception: response.exception, message: response.errorMessage)));
      }
    }

  }

  // todo make action of this func
  void _changeVisibility(){
    emit(state.copyWith(obscureText: !state.isObscureText));
  }
}