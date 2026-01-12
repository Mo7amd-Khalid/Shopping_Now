import 'package:injectable/injectable.dart';
import 'package:route_e_commerce_v2/features/wish_list/data/data_source/contract/wish_list_remote_data_source.dart';
import 'package:route_e_commerce_v2/features/wish_list/data/models/add_or_remove_product.dart';
import 'package:route_e_commerce_v2/features/wish_list/data/models/wish_list_response_dto.dart';
import 'package:route_e_commerce_v2/network/api_client.dart';
import 'package:route_e_commerce_v2/network/results.dart';
import 'package:route_e_commerce_v2/network/safe_call.dart';

@Injectable(as: WishListRemoteDataSource)
class WishListRemoteDataSourceImpl implements WishListRemoteDataSource{

  final ApiClient _apiClient;

  WishListRemoteDataSourceImpl(this._apiClient);


  @override
  Future<Results<WishListResponseDto>> getWishList() async{
    return safeCall(()async{
      var response = await _apiClient.getWishList();
      return Success(data: response);
    });
  }


  @override
  Future<Results<AddOrRemoveProduct>> addProductToWishList(String productId) async{
    return safeCall(()async{
      var response = await _apiClient.addProductToWishList({"productId" : productId});
      return Success(data: response);
    });
  }

  @override
  Future<Results<AddOrRemoveProduct>> removeProductFormWishList(String productId) async{
    return safeCall(()async{
      var response = await _apiClient.removeProductFromWishList(productId);
      return Success(data: response);
    });
  }

}