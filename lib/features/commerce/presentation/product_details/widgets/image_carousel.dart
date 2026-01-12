import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:route_e_commerce_v2/core/di/di.dart';
import 'package:route_e_commerce_v2/core/theme/app_colors.dart';
import 'package:route_e_commerce_v2/core/utils/app_assets.dart';
import 'package:route_e_commerce_v2/core/utils/context_func.dart';
import 'package:route_e_commerce_v2/core/utils/padding.dart';
import 'package:route_e_commerce_v2/features/commerce/domain/entities/product.dart';
import 'package:route_e_commerce_v2/features/wish_list/presentation/cubit/wish_list_contract.dart';
import 'package:route_e_commerce_v2/features/wish_list/presentation/cubit/wish_list_cubit.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({required this.product, super.key});

  final Product product;

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int currentIndex = 0;

  final PageController controller = PageController();

  WishListCubit cubit = getIt();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        currentIndex = controller.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<WishListCubit, WishListState>(
        builder: (_, state) {
          bool isInWishList = false;
          try {
            (state.wishList.data ?? []).firstWhere(
              (wishProduct) => wishProduct.id == widget.product.id,
            );
            isInWishList = true;
          } catch (e) {
            isInWishList = false;
          }
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 1, color: AppColors.blue),
            ),
            height: context.heightSize * 0.42,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: PageView.builder(
                    controller: controller,
                    itemBuilder: (_, index) => CachedNetworkImage(
                      imageUrl:
                          widget.product.images?[index] ??
                          'https://ecommerce.routemisr.com/Route-Academy-products_list/1678303324588-cover.jpeg',
                      fit: BoxFit.fill,
                      width: double.infinity,
                    ),
                    itemCount: widget.product.images!.length,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      isInWishList
                          ? cubit.doActions(
                              RemoveProductFromWishList(
                                widget.product,
                              ),
                            )
                          : cubit.doActions(
                              AddProductToWishList(widget.product),
                            );
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.white,
                      child: SvgPicture.asset(
                        isInWishList
                            ? AppSvgs.activeFavoriteIcon
                            : AppSvgs.inactiveFavoriteIcon,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ).allPadding(8),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < widget.product.images!.length; i++)
                      _indicatorWidget(i == currentIndex).horizontalPadding(2),
                  ],
                ).verticalPadding(6),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget _indicatorWidget(bool isSelected) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      border: Border.all(width: 1, color: AppColors.blue),
      color: AppColors.blue,
    ),
    width: isSelected ? 40 : 8,
    height: 8,
  );
}
