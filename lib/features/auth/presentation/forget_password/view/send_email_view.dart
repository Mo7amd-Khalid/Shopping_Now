import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:route_e_commerce_v2/core/di/di.dart';
import 'package:route_e_commerce_v2/core/routing/routes.dart';
import 'package:route_e_commerce_v2/core/theme/app_colors.dart';
import 'package:route_e_commerce_v2/core/utils/app_assets.dart';
import 'package:route_e_commerce_v2/core/utils/context_func.dart';
import 'package:route_e_commerce_v2/core/utils/resources.dart';
import 'package:route_e_commerce_v2/core/utils/validation.dart';
import 'package:route_e_commerce_v2/core/utils/white_spaces.dart';
import 'package:route_e_commerce_v2/features/auth/presentation/forget_password/cubit/forget_password_contract.dart';
import 'package:route_e_commerce_v2/features/auth/presentation/forget_password/cubit/forget_password_cubit.dart';
import 'package:route_e_commerce_v2/features/auth/widgets/auth_textfield.dart';

class SendEmailView extends StatefulWidget {
  const SendEmailView({super.key});

  @override
  State<SendEmailView> createState() => _SendEmailViewState();
}

class _SendEmailViewState extends State<SendEmailView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  ForgetPasswordCubit cubit = getIt();

  @override
  void initState() {
    super.initState();
    cubit.navigation.listen((navigationState) {
      switch (navigationState) {
        case NavigateToLoginScreen():
          {
            Navigator.pushReplacementNamed(context, Routes.loginRoute);
          }
        case NavigateToVerificationScreen():
          {
            Navigator.pushReplacementNamed(
              context,
              Routes.verificationRoute,
              arguments: navigationState.email,
            );
          }
        case NavigateToResetPasswordScreen():
          throw UnimplementedError();
        case NavigateToSuccessfulResetPasswordScreen():
          throw UnimplementedError();
        case ShowErrorToastNavigation():
          {
            CherryToast.error(
              toastPosition: Position.bottom,
              title: Text(
                navigationState.message,
                style: const TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ).show(context);
          }
        case NavigateToSendEmailScreen():
          throw UnimplementedError();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        backgroundColor: AppColors.blue,
        body: Form(
          key: formKey,
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Image.asset(AppImages.logo),
                40.verticalSpace,
                Text(
                  "Forget Password",
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(color: AppColors.white),
                  textAlign: TextAlign.center,
                ),
                16.verticalSpace,
                Text(
                  "Enter your email address to\nreceive a verification code",
                  style: context.textStyle.bodyLarge!.copyWith(
                    color: AppColors.white.withAlpha(150),
                  ),
                  textAlign: TextAlign.center,
                ),
                22.verticalSpace,
                AuthTextField(
                  hintText: "enter your email",
                  title: "E-mail Address",
                  validator: Validation.validateEmail,
                  controller: emailController,
                ),
                30.verticalSpace,
                BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                  builder: (_, state) => ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        cubit.doActions(
                          SendEmailToCheckInAction(emailController.text),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                    ),
                    child: state.sendEmailToCheck.state == States.loading
                        ? const Center(child: CircularProgressIndicator())
                        : Text(
                            "Send Code",
                            style: context.textStyle.titleMedium!.copyWith(
                              color: AppColors.darkBlue,
                            ),
                          ),
                  ),
                ),
                20.verticalSpace,
                BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                  builder: (_, state) => TextButton(
                    onPressed: () {
                      cubit.doActions(GoToLoginAction());
                    },
                    child: Text(
                      "Back to Login",
                      style: context.textStyle.bodyLarge!.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
