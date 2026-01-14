import 'package:E_Commerce/features/order/domain/entities/cart_entity.dart';
import 'package:E_Commerce/network/results.dart';

abstract interface class CartRepository {

  Future<Results<CartEntity>> getUserCartList();
  Future<Results<CartEntity>> addUserCartList(String productId);
  Future<Results<CartEntity>> updateUserCartList(String productId, String count);
  Future<Results<CartEntity>> removeUserCartList(String productId);

}