import 'package:injectable/injectable.dart';
import 'package:E_Commerce/core/base/base_cubit.dart';
import 'package:E_Commerce/core/utils/resources.dart';
import 'package:E_Commerce/features/commerce/domain/entities/product.dart';
import 'package:E_Commerce/features/wish_list/data/models/add_or_remove_product.dart';
import 'package:E_Commerce/features/wish_list/domain/repository/wish_list_repo.dart';
import 'package:E_Commerce/features/wish_list/presentation/cubit/wish_list_contract.dart';
import 'package:E_Commerce/network/results.dart';

@singleton
class WishListCubit extends BaseCubit<WishListState, WishListActions, void> {
  WishListCubit(this._repo) : super(WishListState());

  final WishListRepo _repo;

  @override
  Future<void> doActions(WishListActions action) async {
    switch (action) {
      case AddProductToWishList():
        {
          _addProductToWishList(action.product);
        }
      case RemoveProductFromWishList():
        {
          _removeProductFromWishList(action.product);
        }
      case GetWishListProducts():
        {
          _getWishListProducts();
        }
    }
  }

  Future<void> _addProductToWishList(Product product) async {
    (state.wishList.data ?? []).add(product);
    emit(
      state.copyWith(wishList: Resources.success(data: state.wishList.data)),
    );

    var response = await _repo.addProductToWishList(product.id ?? "");
    switch (response) {
      case Success<AddOrRemoveProduct>():
        {
          emit(state.copyWith(wishList: Resources.success(data: state.wishList.data)));
        }
      case Failure<AddOrRemoveProduct>():
        {
          emit(
            state.copyWith(
              wishList: Resources.failure(
                exception: response.exception,
                message: response.errorMessage,
              ),
            ),
          );
        }
    }
  }

  Future<void> _removeProductFromWishList(Product product) async {
    (state.wishList.data ?? []).remove(product);
    emit(
      state.copyWith(wishList: Resources.success(data: state.wishList.data)),
    );

    var response = await _repo.removeProductFromWishList(product.id??"");
    switch (response) {
      case Success<AddOrRemoveProduct>():
        {
          emit(state.copyWith(wishList: Resources.success(data: state.wishList.data)));
        }
      case Failure<AddOrRemoveProduct>():
        {
          emit(
            state.copyWith(
              wishList: Resources.failure(
                exception: response.exception,
                message: response.errorMessage,
              ),
            ),
          );
        }
    }
  }

  Future<void> _getWishListProducts() async {
    emit(state.copyWith(wishList: const Resources.loading()));
    var response = await _repo.getWishList();
    switch (response) {
      case Success<List<Product>>():
        {
          emit(
            state.copyWith(wishList: Resources.success(data: response.data)),
          );
        }
      case Failure<List<Product>>():
        {
          emit(
            state.copyWith(
              wishList: Resources.failure(
                exception: response.exception,
                message: response.errorMessage,
              ),
            ),
          );
        }
    }
  }
}
