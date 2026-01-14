import 'package:E_Commerce/core/utils/resources.dart';
import 'package:E_Commerce/features/commerce/domain/entities/category.dart';

class CategoryTabState {
  Resources<List<Category>> categories;

  CategoryTabState({this.categories = const Resources.initial()});

  CategoryTabState copyWith({Resources<List<Category>>? resource}) {
    return CategoryTabState(categories: resource ?? categories);
  }
}

sealed class CategoryTabActions{}

class LoadAllCategories extends CategoryTabActions{}

class OnCategoryItemClick extends CategoryTabActions{
  Category category;
  OnCategoryItemClick(this.category);
}


sealed class CategoryTabNavigation{}

class NavigateToProductListScreen extends CategoryTabNavigation{
  Category category;

  NavigateToProductListScreen(this.category);
}


