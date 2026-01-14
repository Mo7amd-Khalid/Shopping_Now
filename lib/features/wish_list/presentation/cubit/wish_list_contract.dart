import 'package:E_Commerce/core/utils/resources.dart';
import 'package:E_Commerce/features/commerce/domain/entities/product.dart';

class WishListState {
  Resources<List<Product>> wishList;

  WishListState({
    this.wishList = const Resources.initial(),
  });

  WishListState copyWith({
    Resources<List<Product>>? wishList,
  }) {
    return WishListState(
      wishList: wishList ?? this.wishList,
    );
  }
}

sealed class WishListActions {}

class GetWishListProducts extends WishListActions {}

class AddProductToWishList extends WishListActions {
  Product product;

  AddProductToWishList(this.product);
}

class RemoveProductFromWishList extends WishListActions {
  Product product;

  RemoveProductFromWishList(this.product);
}
