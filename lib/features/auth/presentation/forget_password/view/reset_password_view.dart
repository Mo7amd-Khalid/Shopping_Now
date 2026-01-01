import 'dart:math';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:route_e_commerce_v2/core/di/di.dart';
import 'package:route_e_commerce_v2/core/routing/routes.dart';
import 'package:route_e_commerce_v2/core/theme/app_colors.dart';
import 'package:route_e_commerce_v2/core/utils/app_assets.dart';
import 'package:route_e_commerce_v2/core/utils/context_func.dart';
import 'package:route_e_commerce_v2/core/utils/padding.dart';
import 'package:route_e_commerce_v2/core/utils/resources.dart';
import 'package:route_e_commerce_v2/core/utils/validation.dart';
import 'package:route_e_commerce_v2/core/utils/white_spaces.dart';
import 'package:route_e_commerce_v2/features/auth/presentation/forget_password/cubit/forget_password_contract.dart';
import 'package:route_e_commerce_v2/features/auth/presentation/forget_password/cubit/forget_password_cubit.dart';
import 'package:route_e_commerce_v2/features/auth/widgets/auth_textfield.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmationPasswordController =
      TextEditingController();

  ForgetPasswordCubit cubit = getIt();

  @override
  void initState() {
    super.initState();
    cubit.navigation.listen((navigationState) {
      switch (navigationState) {
        case NavigateToLoginScreen():
          throw UnimplementedError();
        case NavigateToVerificationScreen():
          throw UnimplementedError();
        case NavigateToResetPasswordScreen():
          throw UnimplementedError();
        case NavigateToSuccessfulResetPasswordScreen():
          {
            Navigator.pushReplacementNamed(
              context,
              Routes.successfulResetPasswordRoute,
            );
          }
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
          {
            Navigator.pushReplacementNamed(context, Routes.forgetPasswordRoute);
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
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
                  "Reset Password",
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(color: AppColors.white),
                  textAlign: TextAlign.center,
                ),
                16.verticalSpace,
                Text(
                  "Enter your new password",
                  style: context.textStyle.bodyLarge!.copyWith(
                    color: AppColors.white.withAlpha(150),
                  ),
                  textAlign: TextAlign.center,
                ).horizontalPadding(16),
                20.verticalSpace,
                BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                  builder:(_,state) => AuthTextField(
                    hintText: "enter new password",
                    title: "New Password",
                    validator: Validation.validatePassword,
                    obscureText: state.isObscureNewPassword,
                    controller: passwordController,
                    suffixIcon: IconButton(
                      onPressed: () {
                        cubit.doActions(ChangeNewPasswordVisibility());
                      },
                      icon: Icon(
                        state.isObscureNewPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
                30.verticalSpace,
                BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                  builder: (_,state) => AuthTextField(
                    hintText: "confirm password",
                    title: "Confirm Password",
                    validator: (value) {
                      return Validation.validateConfirmPassword(
                        password: passwordController.text,
                        confirmPassword: confirmationPasswordController.text,
                      );
                    },
                    controller: confirmationPasswordController,
                    obscureText: state.isObscureConfirmPassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        cubit.doActions(ChangeConfirmationPasswordVisibility());
                      },
                      icon: Icon(
                        state.isObscureConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),

                30.verticalSpace,

                BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                  builder: (_, state) => ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        cubit.doActions(
                          ResetPasswordAction(
                            email: email,
                            newPassword: confirmationPasswordController.text,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                    ),
                    child: state.resetPassword.state == States.loading
                        ? const Center(child: CircularProgressIndicator())
                        : Text(
                            "Reset Password",
                            style: context.textStyle.titleMedium!.copyWith(
                              color: AppColors.darkBlue,
                            ),
                          ),
                  ),
                ),

                BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                  builder: (_, state) => TextButton(
                    onPressed: () {
                      cubit.doActions(GoToSendEmailAction());
                    },
                    child: Text(
                      "Resent verification code",
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
