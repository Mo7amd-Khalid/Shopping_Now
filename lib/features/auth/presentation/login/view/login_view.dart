import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:route_e_commerce_v2/core/di/di.dart';
import 'package:route_e_commerce_v2/core/l10n/translations/app_localizations.dart';
import 'package:route_e_commerce_v2/core/routing/routes.dart';
import 'package:route_e_commerce_v2/core/theme/app_colors.dart';
import 'package:route_e_commerce_v2/core/utils/app_assets.dart';
import 'package:route_e_commerce_v2/core/utils/validation.dart';
import 'package:route_e_commerce_v2/features/auth/widgets/auth_textfield.dart';
import '../../../../../core/utils/resources.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_state.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  LoginCubit cubit = getIt();

  @override
  void initState() {
    super.initState();
    cubit.navigation.listen((navigationState) {
      switch (navigationState) {
        case GoToRegisterScreen():
          {
            Navigator.pushReplacementNamed(context, Routes.registerRoute);
          }
        case GoToHomeScreen():
          {
            CherryToast.success(
              toastPosition: Position.bottom,
              title: Text(
                navigationState.message,
                style: const TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ).show(context);
            Navigator.pushReplacementNamed(context, Routes.navigationRoute);
          }
        case ShowToastError():
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
        case GoToForgetPasswordScreen():
          {
            Navigator.pushReplacementNamed(context, Routes.forgetPasswordRoute);
          }
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(AppImages.logo),
                    const SizedBox(height: 40),
                    Text(
                      AppLocalizations.of(context)!.welcomeBackToRoute,
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium!.copyWith(color: AppColors.white),
                    ),

                    Text(
                      AppLocalizations.of(context)!.pleaseSignInWithYourMail,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    AuthTextField(
                      title: AppLocalizations.of(context)!.enterYourMail,
                      hintText: AppLocalizations.of(context)!.mail,
                      validator: Validation.validateEmail,
                      controller: emailController,
                    ),
                    const SizedBox(height: 16),

                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (_, state) => AuthTextField(
                        title: AppLocalizations.of(context)!.enterYourPassword,
                        hintText: AppLocalizations.of(context)!.password,
                        validator: Validation.validatePassword,
                        obscureText: state.isObscureText,
                        controller: passwordController,
                        suffixIcon: IconButton(
                          onPressed: () {
                            cubit.doActions(ChangeVisibility());
                          },
                          icon: Icon(
                            state.isObscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            cubit.doActions(NavigatorToForgetPasswordAction());
                          },
                          child: Text(
                            AppLocalizations.of(context)!.forgetPassword,
                            style: Theme.of(context).textTheme.bodySmall!
                                .copyWith(color: AppColors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (_, state) => ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.doActions(
                              LoginUserAction(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                        ),
                        child: state.loginResources.state == States.loading
                            ? const Center(child: CircularProgressIndicator())
                            : Text(
                                AppLocalizations.of(context)!.signIn,
                                style: Theme.of(context).textTheme.titleMedium!
                                    .copyWith(color: AppColors.darkBlue),
                              ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.dontHaveAnAccount,
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(color: AppColors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            cubit.doActions(NavigatorToRegisterAction());
                          },

                          child: Text(
                            AppLocalizations.of(context)!.createAccount,
                            style: Theme.of(context).textTheme.bodySmall!
                                .copyWith(color: AppColors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
