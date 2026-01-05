import 'package:route_e_commerce_v2/features/commerce/data/models/product_list_model/pageable_product_response_dto.dart';
import 'package:route_e_commerce_v2/network/results.dart';

abstract interface class GetProductRemote {

  Future<Results<PageableProductResponseDto>> getProductList(String categoryId, int page);


}