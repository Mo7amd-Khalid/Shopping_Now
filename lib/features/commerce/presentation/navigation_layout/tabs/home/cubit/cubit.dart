import 'package:injectable/injectable.dart';
import 'package:route_e_commerce_v2/core/base/base_cubit.dart';
import 'package:route_e_commerce_v2/core/utils/resources.dart';
import 'package:route_e_commerce_v2/features/commerce/domain/entities/category.dart';
import 'package:route_e_commerce_v2/features/commerce/domain/use_case/commerce_use_case.dart';
import 'package:route_e_commerce_v2/features/commerce/presentation/navigation_layout/tabs/home/cubit/contract.dart';
import 'package:route_e_commerce_v2/network/results.dart';

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


  void _onCategoryItemClick(Category category)
  {
    emitNavigation(NavigateToProductListScreen(category));
  }

}