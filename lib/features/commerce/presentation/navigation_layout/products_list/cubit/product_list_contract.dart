import 'package:route_e_commerce_v2/core/utils/resources.dart';
import 'package:route_e_commerce_v2/features/commerce/domain/entities/product.dart';

class ProductListState {
  int currentPage;
  int numOfPage;
  Resources<List<Product>> products;

  ProductListState({
    this.currentPage = 1,
    this.numOfPage = 1,
    this.products = const Resources.initial(),
  });

  ProductListState copyWith({
    int? currentPage,
    int? numOfPage,
    Resources<List<Product>>? products,
  }) {
    return ProductListState(
      currentPage: currentPage ?? this.currentPage,
      numOfPage: numOfPage ?? this.numOfPage,
      products: products ?? this.products,
    );
  }
}

sealed class ProductListActions{}

class LoadPageableProductsList extends ProductListActions{
  String categoryId;

  LoadPageableProductsList(this.categoryId);
}

class GoToProductDetails extends ProductListActions{
  Product product;

  GoToProductDetails(this.product);
}


sealed class ProductListNavigation{}

class NavigateToProductDetailsScreen extends ProductListNavigation{
  Product product;
  NavigateToProductDetailsScreen(this.product);
}
