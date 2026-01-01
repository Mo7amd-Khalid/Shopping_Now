import 'package:injectable/injectable.dart';
import 'package:route_e_commerce_v2/core/base/base_cubit.dart';
import 'package:route_e_commerce_v2/core/utils/resources.dart';
import 'package:route_e_commerce_v2/features/auth/data/models/forget_password_response.dart';
import 'package:route_e_commerce_v2/features/auth/domain/use_case/forget_password_use_case.dart';
import 'package:route_e_commerce_v2/features/auth/presentation/forget_password/cubit/forget_password_contract.dart';
import 'package:route_e_commerce_v2/features/auth/presentation/login/view/cubit/login_state.dart';
import 'package:route_e_commerce_v2/network/results.dart';


@injectable
class ForgetPasswordCubit extends BaseCubit<ForgetPasswordState, ForgetPasswordActions, ForgetPasswordNavigation>{
  ForgetPasswordCubit(this.useCase) : super(ForgetPasswordState());

  ForgetPasswordUseCase useCase;

  @override
  Future<void> doActions(ForgetPasswordActions action) async{
    switch (action) {

      case GoToLoginAction():{
        _navigateToLoginScreen();
      }
      case GoToSendEmailAction():{
        _navigateToSendEmailScreen();
      }

      case SendEmailToCheckInAction():{
        _checkEmail(action.email);
      }
      case VerifySentCodeAction():{
        _verifySentCode(email: action.email, code: action.code);
      }
      case ResetPasswordAction():{
        _resetPasswordScreen(email: action.email, newPassword: action.newPassword);

      }

      case ChangeNewPasswordVisibility():{
        _changeNewPasswordVisibility();
      }
      case ChangeConfirmationPasswordVisibility():{
        _changeConfirmationPasswordVisibility();
      }
    }
  }


  void _navigateToLoginScreen(){
    emitNavigation(NavigateToLoginScreen());
  }

  void _navigateToSendEmailScreen(){
    emitNavigation(NavigateToSendEmailScreen());
  }

  Future<void> _checkEmail(String email) async {
    emit(state.copyWith(sendEmailResource: const Resources.loading()));
    var response = await useCase.sendEmailToCheckIn(email);
    switch (response) {

      case Success<ForgetPasswordResponse>():
        {
          emit(state.copyWith(sendEmailResource:  Resources.success(message: response.data!.message , data: response.data)));
          emitNavigation(NavigateToVerificationScreen(email));
        }
      case Failure<ForgetPasswordResponse>():{
        emit(state.copyWith(sendEmailResource:  Resources.failure(exception: response.exception, message: response.errorMessage)));
        emitNavigation(ShowErrorToastNavigation(response.errorMessage));
      }
    }
  }


  Future<void> _verifySentCode({required String code,required String email})async{
    emit(state.copyWith(verifyCodeResource: const Resources.loading()));
    var response = await useCase.verifySentCode(code);
    switch (response) {

      case Success<ForgetPasswordResponse>():{
        emit(state.copyWith(verifyCodeResource: Resources.success(message: response.data!.status, data: response.data)));
        emitNavigation(NavigateToResetPasswordScreen(email));
      }
      case Failure<ForgetPasswordResponse>():{
        emit(state.copyWith(verifyCodeResource: Resources.failure(exception: response.exception, message: response.errorMessage)));
        emitNavigation(ShowErrorToastNavigation(response.errorMessage));
      }
    }
  }



  Future<void> _resetPasswordScreen({required String email, required String newPassword}) async{
    emit(state.copyWith(resetPasswordResource: const Resources.loading()));

    var response = await useCase.resetPassword(email: email, newPassword: newPassword);

    switch (response) {

      case Success<ForgetPasswordResponse>():{
        emit(state.copyWith(resetPasswordResource: Resources.success(data: response.data, message: response.data!.message)));
        emitNavigation(NavigateToSuccessfulResetPasswordScreen());

      }
      case Failure<ForgetPasswordResponse>():{
        emit(state.copyWith(resetPasswordResource: Resources.failure(exception: response.exception, message: response.errorMessage)));
      }
    }

  }

  void _changeNewPasswordVisibility(){
    emit(state.copyWith(obscurePassword: !state.isObscureNewPassword));
  }

  void _changeConfirmationPasswordVisibility(){
    emit(state.copyWith(obscureConfirmationPassword: !state.isObscureConfirmPassword));
  }
}