import 'package:route_e_commerce_v2/core/utils/resources.dart';


class RegisterState {
  Resources<String> registerResources;

  RegisterState({this.registerResources = const Resources.initial()});

  RegisterState copyWith(Resources<String>? resource) {
    return RegisterState(
        registerResources: resource ?? registerResources
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

