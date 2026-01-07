import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:route_e_commerce_v2/core/di/di.dart';
import 'package:route_e_commerce_v2/core/theme/app_colors.dart';
import 'package:route_e_commerce_v2/core/utils/context_func.dart';
import 'package:route_e_commerce_v2/core/utils/resources.dart';
import 'package:route_e_commerce_v2/core/widgets/custom_product_card.dart';
import 'package:route_e_commerce_v2/features/commerce/domain/entities/category.dart';
import 'package:route_e_commerce_v2/features/commerce/domain/entities/product.dart';
import 'package:route_e_commerce_v2/features/commerce/presentation/navigation_layout/products/cubit/product_list_contract.dart';
import 'package:route_e_commerce_v2/features/commerce/presentation/navigation_layout/products/cubit/product_list_cubit.dart';
import 'package:route_e_commerce_v2/features/order/presentation/cubit/cart_cubit.dart';
import 'package:route_e_commerce_v2/features/order/presentation/cubit/contract.dart';
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

  @override
  void initState() {
    super.initState();
    cubit.doActions(LoadPageableProductsList(widget.category.id ?? ""));
    cartCubit.doActions(LoadUserCartList());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
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
                            title: 'Softride Enzo NXT',
                            description: 'Sole Material: Rubber, Colour: RED, Department: Men',
                            price: 2999,
                            priceAfterDiscount: 2699,
                            imageCover:
                            'https://ecommerce.routemisr.com/Route-Academy-products/1680399913757-cover.jpeg',
                            images: [
                              'https://ecommerce.routemisr.com/Route-Academy-products/1680399913850-1.jpeg',
                              'https://ecommerce.routemisr.com/Route-Academy-products/1680399913851-4.jpeg',
                              'https://ecommerce.routemisr.com/Route-Academy-products/1680399913850-2.jpeg',
                            ],
                            ratingsAverage: 2.8 + (1 % 5) * 0.1,
                            ratingsQuantity: 20 + 1,
                            quantity: 100 + 1,
                          )),
                        );
                      }
                      return CustomProductCard(product: products[index]);
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
