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
import 'package:route_e_commerce_v2/core/utils/white_spaces.dart';
import 'package:route_e_commerce_v2/features/auth/presentation/forget_password/cubit/forget_password_contract.dart';
import 'package:route_e_commerce_v2/features/auth/presentation/forget_password/cubit/forget_password_cubit.dart';
import 'package:route_e_commerce_v2/features/auth/presentation/forget_password/view/widget/otp_input.dart';

class VerificationView extends StatefulWidget {
  const VerificationView({super.key});

  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
          {
            Navigator.pushReplacementNamed(
              context,
              Routes.resetPasswordRoute,
              arguments: navigationState.email,
            );
          }
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
    String email = ModalRoute.of(context)?.settings.arguments as String;
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
                  "Verification Code",
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(color: AppColors.white),
                  textAlign: TextAlign.center,
                ),
                16.verticalSpace,
                Text(
                  "We sent a code to",
                  style: context.textStyle.bodyLarge!.copyWith(
                    color: AppColors.white.withAlpha(150),
                  ),
                  textAlign: TextAlign.center,
                ).horizontalPadding(16),
                8.verticalSpace,
                Text(
                  email,
                  style: context.textStyle.bodyLarge!.copyWith(
                    color: AppColors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                12.verticalSpace,
                Row(
                  children: List.generate(
                    6,
                    (index) => Expanded(
                      child: OTPInput(
                        controller: controllers[index],
                        autoFocus: index == 0,
                      ),
                    ),
                  ),
                ),
                20.verticalSpace,
                Text(
                  "Didn`t receive the code?",
                  style: context.textStyle.bodyLarge!.copyWith(
                    color: AppColors.white.withAlpha(150),
                  ),
                  textAlign: TextAlign.center,
                ).horizontalPadding(16),
                BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                  builder: (_, state) => TextButton(
                    onPressed: () {
                      cubit.doActions(SendEmailToCheckInAction(email));
                    },
                    child: Text(
                      "Resend",
                      style: context.textStyle.bodyLarge!.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),

                BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                  builder: (_, state) => ElevatedButton(
                    onPressed: () {
                      String code = controllers.map((c) => c.text).join();
                      cubit.doActions(
                        VerifySentCodeAction(email: email, code: code),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                    ),
                    child: state.verifySentCode.state == States.loading
                        ? const Center(child: CircularProgressIndicator())
                        : Text(
                            "Verify",
                            style: context.textStyle.titleMedium!.copyWith(
                              color: AppColors.darkBlue,
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
