import 'package:injectable/injectable.dart';
import 'package:E_Commerce/core/utils/app_exeptions.dart';
import 'package:E_Commerce/features/commerce/data/data_source/contract/get_product_remote.dart';
import 'package:E_Commerce/features/commerce/data/models/product_list_model/pageable_product_response_dto.dart';
import 'package:E_Commerce/network/api_client.dart';
import 'package:E_Commerce/network/results.dart';
import 'package:E_Commerce/network/safe_call.dart';

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