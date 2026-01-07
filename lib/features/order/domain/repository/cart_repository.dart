import 'package:route_e_commerce_v2/features/order/domain/entities/cart_entity.dart';
import 'package:route_e_commerce_v2/network/results.dart';

abstract interface class CartRepository {

  Future<Results<CartEntity>> getUserCartList();
  Future<Results<CartEntity>> addUserCartList(String productId);
  Future<Results<CartEntity>> updateUserCartList(String productId, String count);
  Future<Results<CartEntity>> removeUserCartList(String productId);

}