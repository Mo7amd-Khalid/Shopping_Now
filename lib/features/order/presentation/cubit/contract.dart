import 'package:route_e_commerce_v2/core/utils/resources.dart';
import 'package:route_e_commerce_v2/features/order/domain/entities/cart_entity.dart';

class CartState {
  Resources<CartEntity> cart;

  CartState({this.cart = const Resources.initial()});

  CartState copyWith({Resources<CartEntity>? cart}) {
    return CartState(cart: cart ?? this.cart);
  }
}


sealed class CartActions{}

class LoadUserCartList extends CartActions{}

class AddProductToCartList extends CartActions{
  final String productId;

  AddProductToCartList(this.productId);
}

class UpdateProduct extends CartActions{
  final String productId;
  final String count;

  UpdateProduct(this.productId, this.count);
}

class RemoveProductFromCartList extends CartActions{
  final String productId;

  RemoveProductFromCartList(this.productId);
}