import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:E_Commerce/core/di/di.dart';
import 'package:E_Commerce/core/theme/app_colors.dart';
import 'package:E_Commerce/core/utils/dummy_data_provider.dart';
import 'package:E_Commerce/core/utils/resources.dart';
import 'package:E_Commerce/core/widgets/custom_product_card.dart';
import 'package:E_Commerce/features/commerce/domain/entities/product.dart';
import 'package:E_Commerce/features/order/presentation/cubit/cart_cubit.dart';
import 'package:E_Commerce/features/wish_list/presentation/cubit/wish_list_contract.dart';
import 'package:E_Commerce/features/wish_list/presentation/cubit/wish_list_cubit.dart';
import 'package:shimmer/shimmer.dart';

class FavoriteTabView extends StatefulWidget {
  const FavoriteTabView({super.key});

  @override
  State<FavoriteTabView> createState() => _FavoriteTabViewState();
}

class _FavoriteTabViewState extends State<FavoriteTabView> {
  List<Product> products = DummyDataProvider.generateProducts();

  WishListCubit wishCubit = getIt();
  CartCubit cartCubit = getIt();

  @override
  void initState() {
    super.initState();
    wishCubit.doActions(GetWishListProducts());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: wishCubit),
        BlocProvider.value(value: cartCubit),
      ],
      child: BlocBuilder<WishListCubit, WishListState>(
        builder: (_, state) {
          List<Product>? products = state.wishList.state == States.success
              ? (state.wishList.data ?? [])
              : DummyDataProvider.generateProducts();
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.6,
            ),
            itemBuilder: (_, index) {
              if (state.wishList.state == States.success) {
                return CustomProductCard(
                  product: products[index],
                  onTap: (product) {},
                  cartCubit: cartCubit,
                  wishListCubit: wishCubit,
                );
              } else {
                return Shimmer(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.grey.withAlpha(30),
                      AppColors.grey.withAlpha(10),
                    ],
                  ),
                  child: CustomProductCard(
                    product: products[index],
                    onTap: (product) {},
                    cartCubit: cartCubit,
                    wishListCubit: wishCubit,
                  ),
                );
              }
            },
            itemCount: products.length,
          );
        },
      ),
    );
  }
}
