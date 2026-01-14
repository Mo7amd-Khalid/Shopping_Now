import 'package:E_Commerce/features/order/data/models/cart_response_dto.dart';
import 'package:E_Commerce/network/results.dart';

abstract interface class CartRemoteDataSource {
  Future<Results<CartResponseDto>> getUserCartList();
  Future<Results<CartResponseDto>> addUserCartList(String productId);
  Future<Results<CartResponseDto>> updateUserCartList(String productId, String count);
  Future<Results<CartResponseDto>> removeUserCartList(String productId);
}