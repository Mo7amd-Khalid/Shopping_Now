import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:E_Commerce/core/theme/app_colors.dart';
import 'package:E_Commerce/core/utils/dummy_data_provider.dart';
import 'package:E_Commerce/core/utils/resources.dart';
import 'package:E_Commerce/features/commerce/domain/entities/category.dart';
import 'package:E_Commerce/features/commerce/presentation/navigation_layout/tabs/home/cubit/contract.dart';
import 'package:E_Commerce/features/commerce/presentation/navigation_layout/tabs/home/cubit/cubit.dart';
import 'package:shimmer/shimmer.dart';
import 'category_widget.dart';

class CategoriesList extends StatelessWidget {
  final HomeTabCubit cubit;

  const CategoriesList({required this.cubit, super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<HomeTabCubit, HomeTabState>(
        builder: (_, state) {
          List<Category> categories = state.categories.state == States.success
              ? state.categories.data ?? []
              : DummyDataProvider.generateCategories();
          return SizedBox(
            height: 260,
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.3,
              ),
              itemBuilder: (context, index) {
                return state.categories.state == States.success ?
                CategoryWidget(category: categories[index], onItemClick: (category){
                  cubit.doActions(OnCategoryItemClick(category));
                },) :
                Shimmer(gradient: LinearGradient(colors: [
                      AppColors.grey.withAlpha(30),
                      AppColors.grey.withAlpha(10),
                    ]), child: CategoryWidget(category: categories[index]));
              },
              scrollDirection: Axis.horizontal,
              itemCount: categories.isEmpty ? 20 : categories.length,
            ),
          );
        },
      ),
    );
  }
}
