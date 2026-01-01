import 'package:route_e_commerce_v2/core/utils/resources.dart';


class RegisterState {
  Resources<String> registerResources;

  bool isObscurePassword;
  bool isObscureConfirmPassword;

  RegisterState({
    this.registerResources = const Resources.initial(),
    this.isObscureConfirmPassword = true,
    this.isObscurePassword = true,
  });

  RegisterState copyWith({Resources<String>? resource, bool? passwordObscure, bool? confirmPasswordObscure}) {
    return RegisterState(
        registerResources: resource ?? registerResources,
      isObscurePassword:  passwordObscure ?? isObscurePassword,
      isObscureConfirmPassword: confirmPasswordObscure?? isObscureConfirmPassword
    );
  }
}


sealed class RegisterActions {}

class GoToLoginAction extends RegisterActions {}

class RegistrationAction extends RegisterActions {
  String name;
  String email;
  String password;
  String rePassword;

  RegistrationAction(this.name,this.email,this.password,this.rePassword);
}

class ChangePasswordVisibility extends RegisterActions{}

class ChangeConfirmationPasswordVisibility extends RegisterActions{}


sealed class RegisterNavigation {}

class NavigateToLoginScreen extends RegisterNavigation {}
class ShowErrorToast extends RegisterNavigation {
  String errorMessage;

  ShowErrorToast(this.errorMessage);
}
class ShowSuccessToast extends RegisterNavigation {
  String successMessage;

  ShowSuccessToast(this.successMessage);
}

