import 'package:injectable/injectable.dart';
import 'package:route_e_commerce_v2/core/utils/app_exeptions.dart';
import 'package:route_e_commerce_v2/features/commerce/data/data_source/contract/get_product_remote.dart';
import 'package:route_e_commerce_v2/features/commerce/data/models/product_list_model/pageable_product_response_dto.dart';
import 'package:route_e_commerce_v2/network/api_client.dart';
import 'package:route_e_commerce_v2/network/results.dart';
import 'package:route_e_commerce_v2/network/safe_call.dart';

@Injectable(as: GetProductRemote)
class GetProductRemoteImpl implements GetProductRemote{

  final ApiClient _apiClient;

  GetProductRemoteImpl(this._apiClient);
  @override
  Future<Results<PageableProductResponseDto>> getProductList(String categoryId, int page) async{
    return safeCall(()async{
      var response = await _apiClient.getProductList(categoryId, page);
      if(response.data!.isEmpty)
        {
          return Failure(EmptyPageableProductListException(), "There is no products to show");
        }
      return Success(data: response);
    });

  }

}