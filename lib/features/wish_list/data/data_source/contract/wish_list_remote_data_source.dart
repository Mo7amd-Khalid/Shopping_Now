
import 'package:route_e_commerce_v2/features/wish_list/data/models/add_or_remove_product.dart';
import 'package:route_e_commerce_v2/features/wish_list/data/models/wish_list_response_dto.dart';
import 'package:route_e_commerce_v2/network/results.dart';

abstract interface class WishListRemoteDataSource{

  Future<Results<AddOrRemoveProduct>> addProductToWishList(String productId);

  Future<Results<WishListResponseDto>> getWishList();

  Future<Results<AddOrRemoveProduct>> removeProductFormWishList(String productId);


}