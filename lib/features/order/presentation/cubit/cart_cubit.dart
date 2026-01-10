import 'package:injectable/injectable.dart';
import 'package:route_e_commerce_v2/core/base/base_cubit.dart';
import 'package:route_e_commerce_v2/core/utils/resources.dart';
import 'package:route_e_commerce_v2/features/order/domain/entities/cart_entity.dart';
import 'package:route_e_commerce_v2/features/order/domain/entities/product_in_cart_entity.dart';
import 'package:route_e_commerce_v2/features/order/domain/use_case/cart_use_case.dart';
import 'package:route_e_commerce_v2/features/order/presentation/cubit/contract.dart';
import 'package:route_e_commerce_v2/network/results.dart';

@singleton
class CartCubit extends BaseCubit<CartState, CartActions, void> {
  CartCubit(this._useCase) : super(CartState());

  final CartUseCase _useCase;

  @override
  Future<void> doActions(CartActions action) async {
    switch (action) {
      case LoadUserCartList():
        {
          _loadUserCartList();
        }

      case AddProductToCartList():
        {
          _addProductToCartList(action.productId);
        }
      case UpdateProduct():
        {
          _updateCountOfProduct(action.productId, action.count);
        }
      case RemoveProductFromCartList():
        {
          _removeProductFromCartList(action.productId);
        }
    }
  }

  Future<void> _loadUserCartList() async {
    emit(state.copyWith(cart: const Resources.loading()));
    var response = await _useCase.getUserCartList();

    switch (response) {
      case Success<CartEntity>():
        {
          emit(state.copyWith(cart: Resources.success(data: response.data)));
        }
      case Failure<CartEntity>():
        {
          emit(
            state.copyWith(
              cart: Resources.failure(
                exception: response.exception,
                message: response.errorMessage,
              ),
            ),
          );
        }
    }
  }

  Future<void> _addProductToCartList(String productId) async {
    (state.cart.data?.products ?? []).add(
      ProductInCartEntity(productId, 1, 0),
    );
    emit(state.copyWith(cart: Resources.success(data: state.cart.data)));

    var response = await _useCase.addUserCartList(productId);
    switch (response) {
      case Success<CartEntity>():
        emit(
          state.copyWith(
            cart: Resources.success(
              data: response.data,
              message: response.message,
            ),
          ),
        );
      case Failure<CartEntity>():
        emit(
          state.copyWith(
            cart: Resources.failure(
              exception: response.exception,
              message: response.errorMessage,
            ),
          ),
        );
    }
  }

  Future<void> _removeProductFromCartList(String productId) async {
    (state.cart.data?.products ?? []).removeWhere((product) => product.productId == productId);
    emit(state.copyWith(cart: Resources.success(data: state.cart.data)));

    var response = await _useCase.removeUserCartList(productId);
    switch (response) {
      case Success<CartEntity>():
        emit(
          state.copyWith(
            cart: Resources.success(
              data: response.data,
              message: response.message,
            ),
          ),
        );
      case Failure<CartEntity>():
        emit(
          state.copyWith(
            cart: Resources.failure(
              exception: response.exception,
              message: response.errorMessage,
            ),
          ),
        );
    }
  }

  Future<void> _updateCountOfProduct(String productId, String count)async{
    emit(state.copyWith(isLoading: true));

    var response = await _useCase.updateUserCartList(productId, count);
    switch (response) {

      case Success<CartEntity>():{
        emit(state.copyWith(cart: Resources.success(data: response.data), isLoading: false));
      }
      case Failure<CartEntity>():{
        emit(state.copyWith(cart: Resources.failure(exception: response.exception, message: response.errorMessage)));
      }
    }
  }
}
