import 'package:injectable/injectable.dart';
import 'package:E_Commerce/features/commerce/domain/entities/product.dart';
import 'package:E_Commerce/features/commerce/domain/mapper/commerce_mapper.dart';
import 'package:E_Commerce/features/wish_list/data/data_source/contract/wish_list_remote_data_source.dart';
import 'package:E_Commerce/features/wish_list/data/models/add_or_remove_product.dart';
import 'package:E_Commerce/features/wish_list/data/models/wish_list_response_dto.dart';
import 'package:E_Commerce/features/wish_list/domain/repository/wish_list_repo.dart';
import 'package:E_Commerce/network/results.dart';

@Injectable(as: WishListRepo)
class WishListRepoImpl implements WishListRepo {
  final WishListRemoteDataSource _remoteDataSource;

  WishListRepoImpl(this._remoteDataSource);


  @override
  Future<Results<List<Product>>> getWishList() async{
    var response = await _remoteDataSource.getWishList();

    switch (response) {
      case Success<WishListResponseDto>():
        {
          List<Product> data = (response.data?.data ?? [])
              .map(
                (productDto) =>
                CommerceMapper.convertProductDtoToProduct(productDto),
          )
              .toList();
          return Success(data: data, message: response.message);
        }
      case Failure<WishListResponseDto>():
        return Failure(response.exception, response.errorMessage);
    }
  }

  @override
  Future<Results<AddOrRemoveProduct>> addProductToWishList(String productId) async {
    var response = await _remoteDataSource.addProductToWishList(productId);

    switch (response) {

      case Success<AddOrRemoveProduct>():
        return Success(data: response.data);
      case Failure<AddOrRemoveProduct>():
        return Failure(response.exception, response.errorMessage);
    }
  }

  @override
  Future<Results<AddOrRemoveProduct>> removeProductFromWishList(String productId) async{
    var response = await _remoteDataSource.removeProductFormWishList(productId);

    switch (response) {
      case Success<AddOrRemoveProduct>():
        return Success(data: response.data);
      case Failure<AddOrRemoveProduct>():
        return Failure(response.exception, response.errorMessage);
    }
  }
}
