import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:route_e_commerce_v2/core/di/di.dart';
import 'package:route_e_commerce_v2/core/routing/routes.dart';
import 'package:route_e_commerce_v2/core/theme/app_colors.dart';
import 'package:route_e_commerce_v2/core/utils/context_func.dart';
import 'package:route_e_commerce_v2/core/utils/white_spaces.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/resources.dart';
import '../../../../core/utils/validation.dart';
import '../../widgets/auth_textfield.dart';
import 'cubit/register_contract.dart';
import 'cubit/register_cubit.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RegisterCubit cubit = getIt();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cubit.navigation.listen((navigationState) {
      switch (navigationState) {
        case NavigateToLoginScreen():
          {
            Navigator.pushReplacementNamed(context, Routes.loginRoute);
          }
        case ShowErrorToast():
          {
            CherryToast.error(
              toastPosition: Position.bottom,
              title: Text(
                navigationState.errorMessage,
                style: const TextStyle(color: Colors.black,),
                textAlign: TextAlign.center,
              ),
            ).show(context);
          }
        case ShowSuccessToast():{
          CherryToast.success(
            toastPosition: Position.bottom,
            title: Text(
              navigationState.successMessage,
              style: const TextStyle(color: Colors.black,),
              textAlign: TextAlign.center,
            ),
          ).show(context);
          Navigator.pushReplacementNamed(context, Routes.loginRoute);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: BlocProvider.value(
        value: cubit,
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Image.asset(AppImages.logo),
                16.verticalSpace,
                AuthTextField(
                  title: "Full Name",
                  hintText: "Name",
                  validator: Validation.validateName,
                  controller: nameController,
                ),
                12.verticalSpace,
                AuthTextField(
                  title: "Email",
                  hintText: "Email",
                  validator: Validation.validateEmail,
                  controller: emailController,
                ),
                12.verticalSpace,
                BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (_,state) => AuthTextField(
                    title: "Password",
                    hintText: "Password",
                    validator: Validation.validatePassword,
                    controller: passwordController,
                    obscureText: state.isObscurePassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        cubit.doActions(ChangePasswordVisibility());
                      },
                      icon: Icon(
                        state.isObscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
                12.verticalSpace,
                BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (_,state) => AuthTextField(
                    title: "Confirmation Password",
                    hintText: "Confirmation Password",
                    validator: (value) {
                      return Validation.validateConfirmPassword(
                        password: passwordController.text,
                        confirmPassword: rePasswordController.text,
                      );
                    },
                    controller: rePasswordController,
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
                20.verticalSpace,
                BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (_, state) => ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        cubit.doActions(
                          RegistrationAction(
                            nameController.text,
                            emailController.text,
                            passwordController.text,
                            rePasswordController.text,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                    ),
                    child: state.registerResources.state == States.loading
                        ? const Center(child: CircularProgressIndicator())
                        : Text(
                            "Sign Up",
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(color: AppColors.darkBlue),
                          ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("You already have an account?"),
                    TextButton(
                      onPressed: () {
                        cubit.doActions(GoToLoginAction());
                      },
                      child: Text(
                        "Login",
                        style: context.textStyle.bodyLarge!.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
