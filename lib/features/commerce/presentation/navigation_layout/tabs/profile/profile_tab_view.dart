import 'package:E_Commerce/core/di/di.dart';
import 'package:E_Commerce/core/routing/routes.dart';
import 'package:E_Commerce/core/theme/app_colors.dart';
import 'package:E_Commerce/core/utils/context_func.dart';
import 'package:E_Commerce/core/utils/padding.dart';
import 'package:E_Commerce/core/utils/resources.dart';
import 'package:E_Commerce/core/utils/white_spaces.dart';
import 'package:E_Commerce/features/commerce/presentation/navigation_layout/tabs/profile/cubit/profile_cubit.dart';
import 'package:E_Commerce/features/commerce/presentation/navigation_layout/tabs/profile/cubit/profile_state.dart';
import 'package:E_Commerce/features/order/presentation/cubit/cart_cubit.dart';
import 'package:E_Commerce/features/order/presentation/cubit/contract.dart';
import 'package:E_Commerce/features/wish_list/presentation/cubit/wish_list_contract.dart';
import 'package:E_Commerce/features/wish_list/presentation/cubit/wish_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileTabView extends StatefulWidget {
  const ProfileTabView({super.key});

  @override
  State<ProfileTabView> createState() => _ProfileTabViewState();
}

class _ProfileTabViewState extends State<ProfileTabView> {
  ProfileCubit profileCubit = getIt();
  CartCubit cartCubit = getIt();
  WishListCubit wishListCubit = getIt();

  @override
  void initState() {
    super.initState();
    profileCubit.doActions(GetProfileData());
    profileCubit.navigation.listen((navigationState){
      switch (navigationState) {

        case NavigateToLoginScreen():{
          Navigator.pushReplacementNamed(context, Routes.loginRoute);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: profileCubit),
        BlocProvider.value(value: cartCubit),
        BlocProvider.value(value: wishListCubit),
      ],
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (_, state) {
          switch (state.userData.state) {
            case States.initial:
            case States.loading:
              return const Center(child: CircularProgressIndicator());
            case States.success:
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome, ${state.userData.data?.decoded?.name ?? ""}",
                    style: context.textStyle.bodyLarge!.copyWith(
                      color: AppColors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  35.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<CartCubit, CartState>(
                        builder: (_, state) => Expanded(
                          child: Column(
                            children: [
                              Text(
                                state.cart.data?.numOfCartItems.toString() ?? "0",
                                style: context.textStyle.bodyMedium!.copyWith(
                                  color: AppColors.blue,
                                ),
                              ),
                              Text(
                                "Product in Cart",
                                style: context.textStyle.bodyMedium!.copyWith(
                                  color: AppColors.blue,

                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                        child: VerticalDivider(
                          width: 40,
                          color: AppColors.blue,
                          thickness: 2,
                        ),
                      ),
                      BlocBuilder<WishListCubit, WishListState>(
                        builder: (_, state) => Expanded(
                          child: Column(
                            children: [
                              Text(
                                state.wishList.data?.length.toString() ?? "0",
                                style: context.textStyle.bodyMedium!.copyWith(
                                  color: AppColors.blue,
                                ),
                              ),
                              Text(
                                "Product in Wish List",
                                style: context.textStyle.bodyMedium!.copyWith(
                                  color: AppColors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  55.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            //todo update user data
                          },
                          child: const Text("Update Your Data"),
                        ),
                      ),
                      10.horizontalSpace,
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            //todo change password
                          },
                          child: const Text("Reset Password"),
                        ),
                      ),
                    ],
                  ),
                  35.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            profileCubit.doActions(Logout());
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.red,
                          ),
                          child: const Text("Logout"),
                        ),
                      ),
                    ],
                  ),
                ],
              ).allPadding(16);
            case States.failure:
              return Text(state.userData.message ?? "");
          }
        },
      ),
    );
  }
}
