import 'package:E_Commerce/features/commerce/data/models/product_list_model/pageable_product_response_dto.dart';
import 'package:E_Commerce/network/results.dart';

abstract interface class GetProductRemote {

  Future<Results<PageableProductResponseDto>> getProductList(String categoryId, int page);


}