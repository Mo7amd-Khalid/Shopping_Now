import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:E_Commerce/core/theme/app_colors.dart';
import 'package:E_Commerce/core/utils/app_assets.dart';
import 'package:E_Commerce/core/utils/padding.dart';
import 'package:E_Commerce/features/commerce/domain/entities/product.dart';
import 'package:E_Commerce/features/order/presentation/cubit/cart_cubit.dart';
import 'package:E_Commerce/features/order/presentation/cubit/contract.dart';
import 'package:E_Commerce/features/wish_list/presentation/cubit/wish_list_contract.dart';
import 'package:E_Commerce/features/wish_list/presentation/cubit/wish_list_cubit.dart';

class CustomProductCard extends StatelessWidget {
  final Product product;
  final CartCubit cartCubit;
  final WishListCubit wishListCubit;
  final Function(Product) onTap;

  const CustomProductCard({
    super.key,
    required this.cartCubit,
    required this.wishListCubit,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        onTap(product);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: colorScheme.primary.withValues(alpha: .3),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Stack(
                alignment: AlignmentGeometry.topRight,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: CachedNetworkImage(
                      imageUrl:
                          product.imageCover ??
                          'https://ecommerce.routemisr.com/Route-Academy-products_list/1678303324588-cover.jpeg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  BlocBuilder<WishListCubit, WishListState>(
                    builder: (_, wishListState) {
                      bool isInWishList = false;
                      try {
                        (wishListState.wishList.data ?? []).firstWhere(
                          (wishProduct) => wishProduct.id == product.id,
                        );
                        isInWishList = true;
                      } catch (e) {
                        isInWishList = false;
                      }
                      return InkWell(
                        onTap: () {
                          if (!isInWishList) {
                            wishListCubit.doActions(
                              AddProductToWishList(product),
                            );
                          } else {
                            wishListCubit.doActions(
                              RemoveProductFromWishList(product),
                            );
                          }
                        },
                        child: CircleAvatar(
                          backgroundColor: colorScheme.onPrimary,
                          foregroundColor: AppColors.white,
                          child: SvgPicture.asset(
                            isInWishList
                                ? AppSvgs.activeFavoriteIcon
                                : AppSvgs.inactiveFavoriteIcon,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ).allPadding(8);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title ?? 'Unknown Product',
                    style: textTheme.headlineSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  Text(
                    product.description ?? 'No description available',
                    style: textTheme.headlineSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text(
                        'EGP ${product.priceAfterDiscount ?? product.price} ',
                        style: textTheme.headlineSmall,
                      ),
                      if(product.priceAfterDiscount != null)
                        Text(
                        " ${product.price ?? 0}",
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: colorScheme.primary.withValues(alpha: .6),
                              decoration: TextDecoration.lineThrough,
                            ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 4,
                        children: [
                          Text(
                            'Review (${product.ratingsAverage?.toStringAsFixed(1) ?? 0})',
                            style: textTheme.headlineSmall,
                          ),
                          SvgPicture.asset(AppSvgs.ratingIcon),
                        ],
                      ),
                      BlocBuilder<CartCubit, CartState>(
                        builder: (_, cartState) {
                          bool isInCart = false;
                          try {
                            (cartState.cart.data?.products ?? []).firstWhere(
                              (cartProduct) =>
                                  cartProduct.productId == product.id,
                            );
                            isInCart = true;
                          } catch (e) {
                            isInCart = false;
                          }
                          return IconButton(
                            onPressed: () {
                              if (isInCart) {
                                cartCubit.doActions(
                                  RemoveProductFromCartList(product.id ?? ""),
                                );
                              } else {
                                cartCubit.doActions(
                                  AddProductToCartList(product.id ?? ""),
                                );
                              }
                            },
                            style: IconButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              foregroundColor: colorScheme.onPrimary,
                              visualDensity: VisualDensity.compact,
                              shape: const CircleBorder(),
                            ),
                            icon: Icon(
                              isInCart ? Icons.delete : Icons.add_rounded,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*



* */
