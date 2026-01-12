import 'package:route_e_commerce_v2/features/commerce/domain/entities/product.dart';
import 'package:route_e_commerce_v2/features/wish_list/data/models/add_or_remove_product.dart';
import 'package:route_e_commerce_v2/network/results.dart';

abstract interface class WishListRepo {

  Future<Results<AddOrRemoveProduct>> addProductToWishList(String productId);
  Future<Results<List<Product>>> getWishList();
  Future<Results<AddOrRemoveProduct>> removeProductFromWishList(String productId);


}