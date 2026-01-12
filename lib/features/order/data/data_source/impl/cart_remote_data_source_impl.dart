import 'package:injectable/injectable.dart';
import 'package:route_e_commerce_v2/features/order/data/data_source/contract/cart_remote_data_source.dart';
import 'package:route_e_commerce_v2/features/order/data/models/cart_response_dto.dart';
import 'package:route_e_commerce_v2/network/api_client.dart';
import 'package:route_e_commerce_v2/network/results.dart';
import 'package:route_e_commerce_v2/network/safe_call.dart';

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
