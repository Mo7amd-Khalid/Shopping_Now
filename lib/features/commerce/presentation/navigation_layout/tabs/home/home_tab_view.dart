import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:E_Commerce/core/di/di.dart';
import 'package:E_Commerce/core/l10n/translations/app_localizations.dart';
import 'package:E_Commerce/core/routing/routes.dart';
import 'package:E_Commerce/core/utils/dummy_data_provider.dart';
import 'package:E_Commerce/core/utils/resources.dart';
import 'package:E_Commerce/core/widgets/custom_product_card.dart';
import 'package:E_Commerce/features/commerce/domain/entities/product.dart';
import 'package:E_Commerce/features/commerce/presentation/navigation_layout/tabs/home/cubit/contract.dart';
import 'package:E_Commerce/features/commerce/presentation/navigation_layout/tabs/home/cubit/cubit.dart';
import 'package:E_Commerce/features/commerce/presentation/navigation_layout/tabs/home/widgets/advertisements_list.dart';
import 'package:E_Commerce/features/commerce/presentation/navigation_layout/tabs/home/widgets/categories_list.dart';
import 'package:E_Commerce/features/commerce/presentation/navigation_layout/tabs/home/widgets/section_title.dart';
import 'package:E_Commerce/features/order/presentation/cubit/cart_cubit.dart';
import 'package:E_Commerce/features/order/presentation/cubit/contract.dart';
import 'package:E_Commerce/features/wish_list/presentation/cubit/wish_list_contract.dart';
import 'package:E_Commerce/features/wish_list/presentation/cubit/wish_list_cubit.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../core/theme/app_colors.dart';

class HomeTabView extends StatefulWidget {
  const HomeTabView({super.key});

  @override
  State<HomeTabView> createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView> {
  HomeTabCubit homeCubit = getIt();
  WishListCubit wishCubit = getIt();
  CartCubit cartCubit = getIt();
  List<String> randomCategories = [
    "6439d5b90049ad0b52b90048",
    "6439d58a0049ad0b52b9003f",
    "6439d2d167d9aa4ca970649f",
  ];

  @override
  void initState() {
    super.initState();
    int index = Random().nextInt(3);
    homeCubit.doActions(GetRandomProducts(randomCategories[index]));
    homeCubit.doActions(LoadAllCategories());
    cartCubit.doActions(LoadUserCartList());
    wishCubit.doActions(GetWishListProducts());
    homeCubit.navigation.listen((navigationState) {
      switch (navigationState) {
        case NavigateToProductListScreen():
          {
            Navigator.pushNamed(
              context,
              Routes.productListViewRoute,
              arguments: navigationState.category,
            );
          }
        case NavigateToProductDetailsScreen():
          Navigator.pushNamed(
            context,
            Routes.productDetailsRoute,
            arguments: navigationState.product,
          );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: homeCubit),
        BlocProvider.value(value: cartCubit),
        BlocProvider.value(value: wishCubit),
      ],
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          const AdvertisementsList(),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SectionTitle(title: locale.categories, viewAllVisibility: true),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          CategoriesList(cubit: homeCubit),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
          SectionTitle(title: locale.homeAppliance),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          BlocBuilder<HomeTabCubit, HomeTabState>(
            builder: (_, state) {
              List<Product> products =
                  state.randomProducts.state == States.success
                  ? state.randomProducts.data ?? []
                  : DummyDataProvider.generateProducts();
              return SliverToBoxAdapter(
                child: SizedBox(
                  height: 240,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemExtent: 186,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: state.randomProducts.state == States.success
                            ? CustomProductCard(
                                product: products[index],
                                onTap: (product) {
                                  homeCubit.doActions(OnProductItemClick(product));
                                },
                                wishListCubit: wishCubit,
                                cartCubit: cartCubit,
                              )
                            : Shimmer(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.grey.withAlpha(30),
                                    AppColors.grey.withAlpha(10),
                                  ],
                                ),
                                child: CustomProductCard(
                                  product: products[index],
                                  onTap: (product) {},
                                  wishListCubit: wishCubit,
                                  cartCubit: cartCubit,
                                ),
                              ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
        ],
      ),
    );
  }
}
