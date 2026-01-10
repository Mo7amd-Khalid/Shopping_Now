import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:route_e_commerce_v2/core/di/di.dart';
import 'package:route_e_commerce_v2/core/theme/app_colors.dart';
import 'package:route_e_commerce_v2/core/utils/context_func.dart';
import 'package:route_e_commerce_v2/core/utils/padding.dart';
import 'package:route_e_commerce_v2/core/utils/white_spaces.dart';
import 'package:route_e_commerce_v2/features/commerce/domain/entities/product.dart';
import 'package:route_e_commerce_v2/features/commerce/presentation/product_details/widgets/image_carousel.dart';
import 'package:route_e_commerce_v2/features/order/domain/entities/product_in_cart_entity.dart';
import 'package:route_e_commerce_v2/features/order/presentation/cubit/cart_cubit.dart';
import 'package:route_e_commerce_v2/features/order/presentation/cubit/contract.dart';

class ProductDetails extends StatefulWidget {
  final Product product;

  const ProductDetails({required this.product, super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  CartCubit cubit = getIt();
  ProductInCartEntity? cart;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<CartCubit, CartState>(
        builder: (_, state) {
          try {
            cart = (cubit.state.cart.data?.products ?? []).firstWhere(
              (item) => item.productId == widget.product.id,
            );
          } catch (e) {
            cart = null;
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.product.title ?? ""),
              centerTitle: true,
            ),
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ImageCarousel(images: widget.product.images),
                8.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.product.title ?? "",
                        style: context.textStyle.bodyLarge!.copyWith(
                          color: AppColors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    5.verticalSpace,
                    Text(
                      "EGP ${(widget.product.priceAfterDiscount ?? 0).toString()}",
                      style: context.textStyle.bodyLarge!.copyWith(
                        color: AppColors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (widget.product.price != null)
                      Text(
                        "EGP ${widget.product.price.toString()}",
                        style: context.textStyle.labelSmall!.copyWith(
                          decoration: TextDecoration.lineThrough,
                          color: AppColors.blue,
                          fontSize: 12,
                        ),
                      ).horizontalPadding(3),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellow),
                    Text(
                      widget.product.ratingsAverage.toString(),
                      style: context.textStyle.bodyMedium!.copyWith(
                        color: AppColors.blue,
                      ),
                    ),
                    Text(
                      "(${widget.product.ratingsAverage.toString()})",
                      style: context.textStyle.bodyMedium!.copyWith(
                        color: AppColors.blue,
                      ),
                    ),
                  ],
                ),
                8.verticalSpace,
                Text(
                  "Description",
                  style: context.textStyle.bodyLarge!.copyWith(
                    color: AppColors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.product.description ?? "",
                  style: context.textStyle.bodyMedium!.copyWith(
                    color: AppColors.blue,
                  ),
                ),
              ],
            ),
            bottomNavigationBar: SafeArea(
              child: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Total price",
                        style: context.textStyle.bodyMedium!.copyWith(
                          color: AppColors.blue,
                        ),
                      ),
                      Text(
                        "EGP ${cart != null ? (widget.product.priceAfterDiscount ?? 0) * cart!.count : (widget.product.priceAfterDiscount ?? 0)}",
                        style: context.textStyle.bodyMedium!.copyWith(
                          color: AppColors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  22.horizontalSpace,
                  Expanded(
                    child: cart == null
                        ? FilledButton(
                            onPressed: () {
                              cubit.doActions(
                                AddProductToCartList(widget.product.id ?? ""),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.shopping_cart_checkout_outlined,
                                ),
                                8.horizontalSpace,
                                Text(
                                  "Add to cart",
                                  style: context.textStyle.bodyMedium!.copyWith(
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: AppColors.blue,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    cubit.doActions(
                                      UpdateProduct(
                                        widget.product.id ?? "",
                                        (cart!.count + 1).toString(),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.add_circle_outline_outlined,
                                    color: AppColors.white,
                                  ),
                                ),
                                const Spacer(),
                                state.isLoading
                                    ? SizedBox(
                                        height: context.heightSize * 0.03,
                                        width: context.widthSize*0.07,
                                        child: const CircularProgressIndicator(
                                          color: AppColors.white,
                                        ),
                                      )
                                    : Text(cart!.count.toString()),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    cubit.doActions(
                                      UpdateProduct(
                                        widget.product.id ?? "",
                                        ((cart?.count ?? 0) - 1).toString(),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.remove_circle_outline_outlined,
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              ).horizontalPadding(16),
            ),
          );
        },
      ),
    );
  }
}
