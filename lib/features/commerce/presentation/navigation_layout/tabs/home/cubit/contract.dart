import 'package:route_e_commerce_v2/core/utils/resources.dart';
import 'package:route_e_commerce_v2/features/commerce/domain/entities/category.dart';

class HomeTabState {
  Resources<List<Category>> categories;

  HomeTabState({this.categories = const Resources.initial()});

  HomeTabState copyWith({Resources<List<Category>>? resource}) {
    return HomeTabState(categories: resource ?? categories);
  }
}

sealed class HomeTabActions{}

class LoadAllCategories extends HomeTabActions{}

class OnCategoryItemClick extends HomeTabActions{
  Category category;
  OnCategoryItemClick(this.category);
}


sealed class HomeTabNavigation{}

class NavigateToProductListScreen extends HomeTabNavigation{
  Category category;

  NavigateToProductListScreen(this.category);
}



