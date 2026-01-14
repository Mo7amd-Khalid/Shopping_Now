import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:E_Commerce/core/utils/app_assets.dart';
import 'package:E_Commerce/core/widgets/custom_search_field.dart';

import '../routing/routes.dart';

class SearchAndCartWidget extends StatelessWidget {
  const SearchAndCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        spacing: 8,
        children: [
          const Expanded(child: CustomSearchField()),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, Routes.cartProductsRoute);
            },
            child: SvgPicture.asset(AppSvgs.cartIcon),
          ),
        ],
      ),
    );
  }
}
