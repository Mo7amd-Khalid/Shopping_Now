import 'package:injectable/injectable.dart';
import 'package:route_e_commerce_v2/core/base/base_cubit.dart';
import 'package:route_e_commerce_v2/network/results.dart';
import 'package:route_e_commerce_v2/features/auth/domain/use_case/auth_use_case.dart';
import 'package:route_e_commerce_v2/features/auth/presentation/register/cubit/register_contract.dart';
import '../../../../../core/utils/resources.dart';

@injectable
class RegisterCubit
    extends BaseCubit<RegisterState, RegisterActions, RegisterNavigation> {
  RegisterCubit(this.authUseCase) : super(RegisterState());

  final AuthUseCase authUseCase;


  @override
  Future<void> doActions(RegisterActions action) async {
    switch (action) {
      case GoToLoginAction():
        _goToLoginScreen();
      case RegistrationAction():
        {
          _signUp(action);
        }
      case ChangePasswordVisibility():{
        _changePasswordVisibility();
      }
      case ChangeConfirmationPasswordVisibility():{
        _changeConfirmationPasswordVisibility();
      }
    }
  }

  void _goToLoginScreen() {
    emitNavigation(NavigateToLoginScreen());
  }

  Future<void> _signUp(RegistrationAction action)async{
    emit(state.copyWith(resource:  const Resources.loading()));
    var response = await authUseCase.signUp(
        name: action.name,
        email: action.email,
        password: action.password,
        rePassword: action.rePassword);

    switch (response) {

      case Success<String>():{
        emitNavigation(ShowSuccessToast("Registration Done Successfully"));
        emit(state.copyWith(resource: Resources.success(data: response.data)));
      }
      case Failure<String>():{
        emitNavigation(ShowErrorToast(response.errorMessage));
        emit(state.copyWith(resource: Resources.failure(exception: response.exception, message: response.errorMessage)));
      }
    }

  }

  void _changePasswordVisibility(){
    emit(state.copyWith(passwordObscure: !state.isObscurePassword));
  }

  void _changeConfirmationPasswordVisibility(){
    emit(state.copyWith(confirmPasswordObscure: !state.isObscureConfirmPassword));
  }
}