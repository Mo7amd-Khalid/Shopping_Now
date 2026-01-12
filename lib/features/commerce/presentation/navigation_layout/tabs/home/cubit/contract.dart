import 'package:route_e_commerce_v2/core/utils/resources.dart';
import 'package:route_e_commerce_v2/features/commerce/domain/entities/category.dart';
import 'package:route_e_commerce_v2/features/commerce/domain/entities/product.dart';

class HomeTabState {
  Resources<List<Category>> categories;
  Resources<List<Product>> randomProducts;

  HomeTabState({
    this.categories = const Resources.initial(),
    this.randomProducts = const Resources.initial(),
  });

  HomeTabState copyWith({
    Resources<List<Category>>? categories,
    Resources<List<Product>>? randomProducts,
  }) {
    return HomeTabState(
      categories: categories ?? this.categories,
      randomProducts: randomProducts ?? this.randomProducts,
    );
  }
}

sealed class HomeTabActions {}

class LoadAllCategories extends HomeTabActions {}

class GetRandomProducts extends HomeTabActions{
  String categoryId;

  GetRandomProducts(this.categoryId);
}

class OnCategoryItemClick extends HomeTabActions {
  Category category;

  OnCategoryItemClick(this.category);
}

class OnProductItemClick extends HomeTabActions{
  Product product;
  OnProductItemClick(this.product);
}

sealed class HomeTabNavigation {}

class NavigateToProductListScreen extends HomeTabNavigation {
  Category category;

  NavigateToProductListScreen(this.category);
}

class NavigateToProductDetailsScreen extends HomeTabNavigation{
  Product product;
  NavigateToProductDetailsScreen(this.product);
}
