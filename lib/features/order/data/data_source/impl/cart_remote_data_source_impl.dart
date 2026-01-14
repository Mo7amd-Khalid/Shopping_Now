import 'package:injectable/injectable.dart';
import 'package:E_Commerce/features/order/data/data_source/contract/cart_remote_data_source.dart';
import 'package:E_Commerce/features/order/data/models/cart_response_dto.dart';
import 'package:E_Commerce/network/api_client.dart';
import 'package:E_Commerce/network/results.dart';
import 'package:E_Commerce/network/safe_call.dart';

@Injectable(as: CartRemoteDataSource)
class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final ApiClient _apiClient;

  CartRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Results<CartResponseDto>> getUserCartList() async {
    return safeCall(() async {
      var response = await _apiClient.getUserCartList();
      return Success(data: response);
    });
  }

  @override
  Future<Results<CartResponseDto>> addUserCartList(String productId) async {
    return safeCall(() async {
      var response = await _apiClient.addProductToCart({
        "productId": productId,
      });
      return Success(data: response);
    });
  }

  @override
  Future<Results<CartResponseDto>> removeUserCartList(String productId) async {
    return safeCall(() async {
      var response = await _apiClient.removeProductFromCart(productId);
      return Success(data: response);
    });
  }

  @override
  Future<Results<CartResponseDto>> updateUserCartList(
    String productId,
    String count,
  ) async {
    return safeCall(() async {
      var response = await _apiClient.updateProductToCart(productId, {
        "count": count,
      });
      return Success(data: response);
    });
  }
}
