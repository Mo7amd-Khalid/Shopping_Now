import 'package:route_e_commerce_v2/core/utils/resources.dart';
import 'package:route_e_commerce_v2/features/auth/data/models/forget_password_response.dart';

class ForgetPasswordState {
  Resources<ForgetPasswordResponse> sendEmailToCheck;
  Resources<ForgetPasswordResponse> verifySentCode;
  Resources<ForgetPasswordResponse> resetPassword;

  bool isObscureNewPassword;
  bool isObscureConfirmPassword;

  ForgetPasswordState({
    this.sendEmailToCheck = const Resources.initial(),
    this.verifySentCode = const Resources.initial(),
    this.resetPassword = const Resources.initial(),
    this.isObscureNewPassword = true,
    this.isObscureConfirmPassword = true,
  });

  ForgetPasswordState copyWith({
    Resources<ForgetPasswordResponse>? sendEmailResource,
    Resources<ForgetPasswordResponse>? verifyCodeResource,
    Resources<ForgetPasswordResponse>? resetPasswordResource,
    bool? obscurePassword,
    bool? obscureConfirmationPassword,
  }) {
    return ForgetPasswordState(
      sendEmailToCheck: sendEmailResource ?? sendEmailToCheck,
      verifySentCode: verifyCodeResource ?? verifySentCode,
      resetPassword: resetPasswordResource ?? resetPassword,
      isObscureNewPassword: obscurePassword ?? isObscureNewPassword,
      isObscureConfirmPassword:
          obscureConfirmationPassword ?? isObscureConfirmPassword,
    );
  }
}

sealed class ForgetPasswordActions {}

class GoToLoginAction extends ForgetPasswordActions {}

class GoToSendEmailAction extends ForgetPasswordActions {}

class SendEmailToCheckInAction extends ForgetPasswordActions {
  String email;

  SendEmailToCheckInAction(this.email);
}

class VerifySentCodeAction extends ForgetPasswordActions {
  String email;
  String code;

  VerifySentCodeAction({required this.email, required this.code});
}

class ResetPasswordAction extends ForgetPasswordActions {
  String email;
  String newPassword;

  ResetPasswordAction({required this.email, required this.newPassword});
}

class ChangeNewPasswordVisibility extends ForgetPasswordActions{}

class ChangeConfirmationPasswordVisibility extends ForgetPasswordActions{}




sealed class ForgetPasswordNavigation {}

class NavigateToLoginScreen extends ForgetPasswordNavigation {}

class NavigateToSendEmailScreen extends ForgetPasswordNavigation {}

class NavigateToVerificationScreen extends ForgetPasswordNavigation {
  String email;

  NavigateToVerificationScreen(this.email);
}

class NavigateToResetPasswordScreen extends ForgetPasswordNavigation {
  String email;

  NavigateToResetPasswordScreen(this.email);
}

class NavigateToSuccessfulResetPasswordScreen
    extends ForgetPasswordNavigation {}

class ShowErrorToastNavigation extends ForgetPasswordNavigation {
  String message;

  ShowErrorToastNavigation(this.message);
}
