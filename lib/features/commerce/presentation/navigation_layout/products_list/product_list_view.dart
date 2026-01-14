import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:E_Commerce/core/di/di.dart';
import 'package:E_Commerce/core/routing/routes.dart';
import 'package:E_Commerce/core/theme/app_colors.dart';
import 'package:E_Commerce/core/utils/context_func.dart';
import 'package:E_Commerce/core/utils/resources.dart';
import 'package:E_Commerce/core/widgets/custom_product_card.dart';
import 'package:E_Commerce/features/commerce/domain/entities/category.dart';
import 'package:E_Commerce/features/commerce/domain/entities/product.dart';
import 'package:E_Commerce/features/commerce/presentation/navigation_layout/products_list/cubit/product_list_contract.dart';
import 'package:E_Commerce/features/commerce/presentation/navigation_layout/products_list/cubit/product_list_cubit.dart';
import 'package:E_Commerce/features/order/presentation/cubit/cart_cubit.dart';
import 'package:E_Commerce/features/order/presentation/cubit/contract.dart';
import 'package:E_Commerce/features/wish_list/presentation/cubit/wish_list_contract.dart';
import 'package:E_Commerce/features/wish_list/presentation/cubit/wish_list_cubit.dart';
import 'package:shimmer/shimmer.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({required this.category, super.key});

  final Category category;

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  ProductListCubit cubit = getIt();
  CartCubit cartCubit = getIt();
  WishListCubit wishCubit = getIt();


  @override
  void initState() {
    super.initState();
    cubit.navigation.listen((navigationState){
      switch (navigationState) {

        case NavigateToProductDetailsScreen():{
          Navigator.pushNamed(context, Routes.productDetailsRoute,arguments: navigationState.product);
        }
      }
    });
    cubit.doActions(LoadPageableProductsList(widget.category.id ?? ""));
    cartCubit.doActions(LoadUserCartList());
    wishCubit.doActions(GetWishListProducts());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: cubit),
        BlocProvider.value(value: cartCubit),
        BlocProvider.value(value: wishCubit),
      ],
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          title: Text(widget.category.name ?? ""),
          centerTitle: true,
        ),
        body: BlocBuilder<ProductListCubit, ProductListState>(
          builder: (_, state) {
            List<Product> products = state.products.data ?? [];
            switch (state.products.state) {
              case States.initial:
              case States.loading:
                {
                  return const Center(child: CircularProgressIndicator(),);
                }
              case States.success:
                {
                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.6,
                    ),
                    itemBuilder: (_, index) {
                      if (index == products.length) {
                        cubit.doActions(
                          LoadPageableProductsList(widget.category.id ?? ""),
                        );
                        // dummy data
                        return Shimmer(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.grey.withAlpha(30),
                              AppColors.grey.withAlpha(10),
                            ],
                          ),
                          child: CustomProductCard(product: Product(
                            id: '1',
                            title: '',
                            description: '',
                            price: 0,
                            priceAfterDiscount: 2699,
                            imageCover: '',
                            images: [],
                            ratingsAverage: 0,
                            ratingsQuantity: 0,
                            quantity: 0,
                          ),onTap: (product){},cartCubit: cartCubit, wishListCubit: wishCubit,),
                        );
                      }
                      return CustomProductCard(product: products[index],onTap: (product){
                        cubit.doActions(GoToProductDetails(product));
                      },
                        cartCubit: cartCubit,
                          wishListCubit: wishCubit,
                      );
                    },
                    itemCount: state.currentPage > state.numOfPage
                        ? state.products.data!.length
                        : state.products.data!.length + 1,
                  );
                }
              case States.failure:
                {
                  return Center(child: Text(state.products.message ?? "",
                    style: context.textStyle.headlineMedium!.copyWith(
                        color: AppColors.darkBlue),),);
                }
            }
          },
        ),
      ),
    );
  }
}
