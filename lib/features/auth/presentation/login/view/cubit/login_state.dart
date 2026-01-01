import 'package:route_e_commerce_v2/core/utils/resources.dart';
import 'package:route_e_commerce_v2/features/auth/data/models/auth_response_dto.dart';

class LoginState {
  Resources<AuthResponseDto> loginResources;

  bool isObscureText;

  LoginState({
    this.loginResources = const Resources.initial(),
    this.isObscureText = true,
  });

  LoginState copyWith({
    Resources<AuthResponseDto>? loginResources,
    bool? obscureText,
  }) {
    return LoginState(
      loginResources: loginResources ?? this.loginResources,
      isObscureText: obscureText ?? isObscureText,
    );
  }
}

sealed class LoginActions {}

class NavigatorToRegisterAction extends LoginActions {}

class NavigatorToForgetPasswordAction extends LoginActions {}

class LoginUserAction extends LoginActions {
  String email;
  String password;

  LoginUserAction({required this.email, required this.password});
}

class ChangeVisibility extends LoginActions{}

sealed class LoginNavigation {}

class GoToRegisterScreen extends LoginNavigation {}

class GoToForgetPasswordScreen extends LoginNavigation {}

class GoToHomeScreen extends LoginNavigation {
  String message;

  GoToHomeScreen(this.message);
}

class ShowToastError extends LoginNavigation {
  String message;

  ShowToastError(this.message);
}
