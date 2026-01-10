import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:route_e_commerce_v2/core/theme/app_colors.dart';
import 'package:route_e_commerce_v2/core/utils/app_assets.dart';
import 'package:route_e_commerce_v2/core/utils/context_func.dart';
import 'package:route_e_commerce_v2/core/utils/padding.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({required this.images, super.key});

  final List<String>? images;

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int currentIndex = 0;

  final PageController controller = PageController();

  @override
  void initState() {
    super.initState();
    controller.addListener((){
      setState(() {
        currentIndex = controller.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              width: 1,
              color: AppColors.blue
          )
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
              widget.images?[index] ??
                  'https://ecommerce.routemisr.com/Route-Academy-products_list/1678303324588-cover.jpeg',
              fit: BoxFit.fill,
              width: double.infinity,
            ),
              itemCount: widget.images!.length,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                //TODO: Implement favorite toggle functionality
              },
              child: CircleAvatar(
                backgroundColor: AppColors.white,
                child: SvgPicture.asset(
                  AppSvgs.inactiveFavoriteIcon,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ).allPadding(8),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for(int i = 0; i < widget.images!.length; i++)
                _indicatorWidget(i == currentIndex).horizontalPadding(2),
            ],
          ).verticalPadding(6),


        ],
      ),
    );
  }
}

Widget _indicatorWidget(bool isSelected){
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      border: Border.all(
        width: 1,
        color: AppColors.blue
      ),
      color: AppColors.blue,
    ),
    width: isSelected? 40 : 8,
    height: 8,
  );
}