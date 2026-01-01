import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:route_e_commerce_v2/core/di/di.dart';
import 'package:route_e_commerce_v2/core/routing/routes.dart';
import 'package:route_e_commerce_v2/core/theme/app_colors.dart';
import 'package:route_e_commerce_v2/core/utils/app_assets.dart';
import 'package:route_e_commerce_v2/core/utils/context_func.dart';
import 'package:route_e_commerce_v2/core/utils/white_spaces.dart';
import 'package:route_e_commerce_v2/features/auth/presentation/forget_password/cubit/forget_password_contract.dart';
import 'package:route_e_commerce_v2/features/auth/presentation/forget_password/cubit/forget_password_cubit.dart';

class SuccessfulResetPasswordView extends StatefulWidget {
  const SuccessfulResetPasswordView({super.key});

  @override
  State<SuccessfulResetPasswordView> createState() => _SuccessfulResetPasswordViewState();
}

class _SuccessfulResetPasswordViewState extends State<SuccessfulResetPasswordView> {

  ForgetPasswordCubit cubit = getIt();

  @override
  void initState() {
    super.initState();
    cubit.navigation.listen((navigationState){
      switch (navigationState) {
        case NavigateToLoginScreen():
          {
            Navigator.pushReplacementNamed(context, Routes.loginRoute);
          }

        case NavigateToVerificationScreen():
          throw UnimplementedError();
        case NavigateToResetPasswordScreen():
          throw UnimplementedError();
        case NavigateToSuccessfulResetPasswordScreen():
          throw UnimplementedError();
        case ShowErrorToastNavigation():
          throw UnimplementedError();
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
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Image.asset(AppImages.logo),
              Container(
                width: context.widthSize *0.3,
                height: context.heightSize * 0.12,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    AppColors.white.withAlpha(100),
                    AppColors.grey.withAlpha(100)
                  ]),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.greenAccent, width: 5),
                ),
                child: const Center(
                  child: Icon(Icons.check, color: Colors.white, size: 55,),
                ),
              ),
              16.verticalSpace,
              Text(
                "Password Reset Successfully",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(color: AppColors.white),
                textAlign: TextAlign.center,
              ),
              16.verticalSpace,
              Text(
                "You can now login using\nyour new password",
                style: context.textStyle.bodyLarge!.copyWith(
                  color: AppColors.white.withAlpha(150),
                ),
                textAlign: TextAlign.center,
              ),
              22.verticalSpace,
              BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                builder:(_, state) => ElevatedButton(
                  onPressed: ()
                  {
                    cubit.doActions(GoToLoginAction());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white,
                  ),
                  child: Text(
                    "Go to Login",
                    style: context.textStyle.titleMedium!.copyWith(
                      color: AppColors.darkBlue,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
