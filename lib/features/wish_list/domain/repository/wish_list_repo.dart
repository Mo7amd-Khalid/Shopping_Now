import 'package:E_Commerce/features/commerce/domain/entities/product.dart';
import 'package:E_Commerce/features/wish_list/data/models/add_or_remove_product.dart';
import 'package:E_Commerce/network/results.dart';

abstract interface class WishListRepo {

  Future<Results<AddOrRemoveProduct>> addProductToWishList(String productId);
  Future<Results<List<Product>>> getWishList();
  Future<Results<AddOrRemoveProduct>> removeProductFromWishList(String productId);


}