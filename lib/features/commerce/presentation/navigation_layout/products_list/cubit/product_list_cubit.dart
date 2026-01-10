import 'package:injectable/injectable.dart';
import 'package:route_e_commerce_v2/core/base/base_cubit.dart';
import 'package:route_e_commerce_v2/core/utils/resources.dart';
import 'package:route_e_commerce_v2/features/commerce/domain/entities/pageable_products.dart';
import 'package:route_e_commerce_v2/features/commerce/domain/entities/product.dart';
import 'package:route_e_commerce_v2/features/commerce/domain/use_case/commerce_use_case.dart';
import 'package:route_e_commerce_v2/features/commerce/presentation/navigation_layout/products_list/cubit/product_list_contract.dart';
import 'package:route_e_commerce_v2/network/results.dart';

@injectable
class ProductListCubit
    extends BaseCubit<ProductListState, ProductListActions, ProductListNavigation> {
  ProductListCubit(this._useCase) : super(ProductListState());

  final CommerceUseCase _useCase;

  @override
  Future<void> doActions(ProductListActions action) async {
    switch (action) {
      case LoadPageableProductsList():
        {
          _loadPageableProductsList(action.categoryId);
        }
      case GoToProductDetails():{
        _navigateToProductDetails(action.product);
      }
    }
  }

  Future<void> _loadPageableProductsList(String categoryId) async {
    if (state.currentPage == 1) {
      emit(state.copyWith(products: const Resources.loading()));
    }

    var response = await _useCase.getProducts(categoryId, state.currentPage);
    switch (response) {
      case Success<PageableProducts>():
        {
          var products = response.data?.products ?? [];
          if (state.numOfPage != 1) {
            products = state.products.data ?? [];
            products.addAll(response.data?.products ?? []);
          }
          emit(
            state.copyWith(
              currentPage: (state.currentPage + 1),
              numOfPage: response.data?.numOfPages ?? state.currentPage,
              products: Resources.success(data: products),
            ),
          );
        }
      case Failure<PageableProducts>():
        {
          emit(
            state.copyWith(
              products: Resources.failure(
                exception: response.exception,
                message: response.errorMessage,
              ),
            ),
          );
        }
    }
  }

  void _navigateToProductDetails(Product product)
  {
    emitNavigation(NavigateToProductDetailsScreen(product));
  }
}
