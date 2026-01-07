import 'package:route_e_commerce_v2/features/order/data/models/cart_response_dto.dart';
import 'package:route_e_commerce_v2/network/results.dart';

abstract interface class CartRemoteDataSource {
  Future<Results<CartResponseDto>> getUserCartList();
  Future<Results<CartResponseDto>> addUserCartList(String productId);
  Future<Results<CartResponseDto>> updateUserCartList(String productId, String count);
  Future<Results<CartResponseDto>> removeUserCartList(String productId);
}