import 'package:injectable/injectable.dart';
import 'package:E_Commerce/core/base/base_cubit.dart';
import 'package:E_Commerce/core/utils/resources.dart';
import 'package:E_Commerce/features/commerce/domain/entities/category.dart';
import 'package:E_Commerce/features/commerce/domain/entities/pageable_products.dart';
import 'package:E_Commerce/features/commerce/domain/entities/product.dart';
import 'package:E_Commerce/features/commerce/domain/use_case/commerce_use_case.dart';
import 'package:E_Commerce/features/commerce/presentation/navigation_layout/tabs/home/cubit/contract.dart';
import 'package:E_Commerce/network/results.dart';

@injectable
class HomeTabCubit extends BaseCubit<HomeTabState, HomeTabActions, HomeTabNavigation>{

  CommerceUseCase useCase;

  HomeTabCubit(this.useCase) : super(HomeTabState());


  @override
  Future<void> doActions(HomeTabActions action) async{
    switch (action) {

      case LoadAllCategories():{
        _getCategories();
      }

      case OnCategoryItemClick():{
        _onCategoryItemClick(action.category);
      }
      case GetRandomProducts():{
        _getRandomProducts(action.categoryId);
      }
      case OnProductItemClick():{
        _onProductItemClick(action.product);

      }
    }
  }



  Future<void> _getCategories()async{
    emit(state.copyWith(categories: const Resources.loading()));
    var response = await useCase.getCategories();
    switch (response) {
      case Success<List<Category>>():{
        emit(state.copyWith(categories: Resources.success(data: response.data)));
      }
      case Failure<List<Category>>():{
        emit(state.copyWith(categories: Resources.failure(exception: response.exception, message: response.errorMessage)));
      }
    }
  }

  Future<void> _getRandomProducts(String categoryId)async{
    emit(state.copyWith(randomProducts: const Resources.loading()));
    var response = await useCase.getProducts(categoryId, 1);
   switch (response) {

     case Success<PageableProducts>():
       emit(state.copyWith(randomProducts: Resources.success(data: response.data?.products)));
     case Failure<PageableProducts>():
       emit(state.copyWith(randomProducts: Resources.failure(exception: response.exception, message: response.errorMessage)));
   }
  }

  void _onCategoryItemClick(Category category)
  {
    emitNavigation(NavigateToProductListScreen(category));
  }

  void _onProductItemClick(Product product){
    emitNavigation(NavigateToProductDetailsScreen(product));
  }
}