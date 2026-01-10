import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:route_e_commerce_v2/core/di/di.dart';
import 'package:route_e_commerce_v2/core/utils/app_assets.dart';
import 'package:route_e_commerce_v2/core/utils/padding.dart';
import 'package:route_e_commerce_v2/features/commerce/domain/entities/product.dart';
import 'package:route_e_commerce_v2/features/order/presentation/cubit/cart_cubit.dart';
import 'package:route_e_commerce_v2/features/order/presentation/cubit/contract.dart';

class CustomProductCard extends StatelessWidget {
  final Product product;
  final CartCubit cartCubit = getIt();
  final Function(Product) onTap;

  CustomProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return BlocProvider.value(
      value: cartCubit,
      child: BlocBuilder<CartCubit, CartState>(
        builder: (_, state) {
          bool isExist = false;
          try {
            (state.cart.data?.products ?? []).firstWhere(
              (cartProduct) => cartProduct.productId == product.id,
            );
            isExist = true;
          } catch (e) {
            isExist = false;
          }

          return InkWell(
            onTap: (){
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
                        InkWell(
                          onTap: () {
                            //TODO: Implement favorite toggle functionality
                          },
                          child: CircleAvatar(
                            backgroundColor: colorScheme.onPrimary,
                            child: SvgPicture.asset(
                              AppSvgs.inactiveFavoriteIcon,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ).allPadding(8),
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
                              'EGP ${product.priceAfterDiscount ?? 0} ',
                              style: textTheme.headlineSmall,
                            ),
                            Text(
                              " ${product.price ?? 0}",
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    color: colorScheme.primary.withValues(
                                      alpha: .6,
                                    ),
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
                            IconButton(
                              onPressed: () {
                                if(isExist)
                                  {
                                    cartCubit.doActions(RemoveProductFromCartList(product.id??""));
                                  }
                                else
                                  {
                                    cartCubit.doActions(AddProductToCartList(product.id??""));
                                  }
                              },
                              style: IconButton.styleFrom(
                                backgroundColor: colorScheme.primary,
                                foregroundColor: colorScheme.onPrimary,
                                visualDensity: VisualDensity.compact,
                                shape: const CircleBorder(),
                              ),
                              icon: Icon(
                                isExist ? Icons.delete : Icons.add_rounded,
                              ),
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
        },
      ),
    );
  }
}
