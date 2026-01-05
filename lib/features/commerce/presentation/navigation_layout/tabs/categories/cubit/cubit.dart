import 'package:injectable/injectable.dart';
import 'package:route_e_commerce_v2/core/base/base_cubit.dart';
import 'package:route_e_commerce_v2/core/utils/resources.dart';
import 'package:route_e_commerce_v2/features/commerce/domain/entities/category.dart';
import 'package:route_e_commerce_v2/features/commerce/domain/use_case/commerce_use_case.dart';
import 'package:route_e_commerce_v2/features/commerce/presentation/navigation_layout/tabs/categories/cubit/cantract.dart';
import 'package:route_e_commerce_v2/network/results.dart';

@injectable
class CategoryTabCubit extends BaseCubit<CategoryTabState, CategoryTabActions, CategoryTabNavigation>{

  CommerceUseCase useCase;

  CategoryTabCubit(this.useCase) : super(CategoryTabState());


  @override
  Future<void> doActions(CategoryTabActions action) async{

    switch (action) {

      case LoadAllCategories():{
        _getCategories();
      }
      case OnCategoryItemClick():
        {
          _goToProductList(action.category);
        }
    }
  }

  Future<void> _getCategories()async{
    emit(state.copyWith(resource: const Resources.loading()));
    var response = await useCase.getCategories();
    switch (response) {

      case Success<List<Category>>():{
        emit(state.copyWith(resource: Resources.success(data: response.data)));
      }
      case Failure<List<Category>>():{
        emit(state.copyWith(resource: Resources.failure(exception: response.exception, message: response.errorMessage)));
      }
    }
  }

  void _goToProductList(Category category)
  {
    emitNavigation(NavigateToProductListScreen(category));
  }
}