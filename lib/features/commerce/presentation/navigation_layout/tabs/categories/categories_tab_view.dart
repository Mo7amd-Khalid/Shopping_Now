import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:route_e_commerce_v2/core/di/di.dart';
import 'package:route_e_commerce_v2/core/routing/routes.dart';
import 'package:route_e_commerce_v2/core/theme/app_colors.dart';
import 'package:route_e_commerce_v2/core/utils/dummy_data_provider.dart';
import 'package:route_e_commerce_v2/core/utils/resources.dart';
import 'package:route_e_commerce_v2/features/commerce/domain/entities/category.dart';
import 'package:route_e_commerce_v2/features/commerce/presentation/navigation_layout/tabs/categories/cubit/cantract.dart';
import 'package:route_e_commerce_v2/features/commerce/presentation/navigation_layout/tabs/categories/cubit/cubit.dart';
import 'package:route_e_commerce_v2/features/commerce/presentation/navigation_layout/tabs/home/widgets/category_widget.dart';
import 'package:shimmer/shimmer.dart';

class CategoriesTabView extends StatefulWidget {
  const CategoriesTabView({super.key});

  @override
  State<CategoriesTabView> createState() => _CategoriesTabViewState();
}

class _CategoriesTabViewState extends State<CategoriesTabView> {
  CategoryTabCubit cubit = getIt();

  @override
  void initState() {
    super.initState();
    cubit.doActions(LoadAllCategories());
    cubit.navigation.listen((navigationState) {
      switch (navigationState) {
        case NavigateToProductListScreen():
          {
            Navigator.pushNamed(
              context,
              Routes.productListViewRoute,
              arguments: navigationState.category,
            );
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<CategoryTabCubit, CategoryTabState>(
        builder: (_, state) {
          List<Category> categories = state.categories.state == States.success
              ? state.categories.data ?? []
              : DummyDataProvider.generateCategories();
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              if (state.categories.state == States.success) {
                return CategoryWidget(
                  category: categories[index],
                  onItemClick: (category) {
                    cubit.doActions(OnCategoryItemClick(category));
                  },
                );
              }
              return Shimmer(
                gradient: LinearGradient(
                  colors: [
                    AppColors.grey.withAlpha(30),
                    AppColors.grey.withAlpha(10),
                  ],
                ),
                child: CategoryWidget(category: categories[index]),
              );
            },
            scrollDirection: Axis.vertical,
            itemCount: categories.isEmpty ? 20 : categories.length,
          );
        },
      ),
    );
  }
}
