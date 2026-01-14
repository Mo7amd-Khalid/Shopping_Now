import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:E_Commerce/core/di/di.dart';
import 'package:E_Commerce/core/theme/app_colors.dart';
import 'package:E_Commerce/core/utils/context_func.dart';
import 'package:E_Commerce/core/utils/resources.dart';
import 'package:E_Commerce/core/widgets/custom_product_card.dart';
import 'package:E_Commerce/features/order/presentation/cubit/cart_cubit.dart';
import 'package:E_Commerce/features/order/presentation/cubit/contract.dart';
import 'package:E_Commerce/features/wish_list/presentation/cubit/wish_list_contract.dart';
import 'package:E_Commerce/features/wish_list/presentation/cubit/wish_list_cubit.dart';

class CartProducts extends StatefulWidget {
  const CartProducts({super.key});

  @override
  State<CartProducts> createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  CartCubit cartCubit = getIt();
  WishListCubit wishListCubit = getIt();

  @override
  void initState() {
    super.initState();
    cartCubit.doActions(LoadUserCartList());
    wishListCubit.doActions(GetWishListProducts());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: cartCubit),
        BlocProvider.value(value: wishListCubit),
      ],
      child: BlocBuilder<CartCubit, CartState>(
        builder: (_, cartState) => Scaffold(
          appBar: AppBar(title: const Text("Cart Products"), centerTitle: true),
          body: cartState.cart.state == States.loading
              ? const Center(child: CircularProgressIndicator())
              : cartState.cart.data!.numOfCartItems == 0
              ? Center(child: Text("No products found in cart", style: context.textStyle.bodyLarge!.copyWith(color: AppColors.blue),))
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.6,
                  ),
                  itemBuilder: (_, index) => CustomProductCard(
                    cartCubit: cartCubit,
                    wishListCubit: wishListCubit,
                    product:
                    cartState.cart.data!.products[index].productDetails,
                    onTap: (product) {},
                  ),
                  itemCount: cartState.cart.data!.products.length,
                ),
        ),
      ),
    );
  }
}
