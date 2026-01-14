import 'package:injectable/injectable.dart';
import 'package:E_Commerce/features/order/data/data_source/contract/cart_remote_data_source.dart';
import 'package:E_Commerce/features/order/data/mapper/cart_mapper.dart';
import 'package:E_Commerce/features/order/data/models/cart_response_dto.dart';
import 'package:E_Commerce/features/order/domain/entities/cart_entity.dart';
import 'package:E_Commerce/features/order/domain/repository/cart_repository.dart';
import 'package:E_Commerce/network/results.dart';


@Injectable(as: CartRepository)
class CartRepoImpl implements CartRepository {

  final CartRemoteDataSource _cartRemoteDataSource;

  CartRepoImpl(this._cartRemoteDataSource);

  @override
  Future<Results<CartEntity>> getUserCartList() async{
    var response = await _cartRemoteDataSource.getUserCartList();
    switch (response) {

      case Success<CartResponseDto>():{
        return Success(data: CartMapper.transferFromCartResponseDtoToCartEntity(response.data!));
      }
      case Failure<CartResponseDto>():{
        return Failure(response.exception, response.errorMessage);
      }
    }
  }

  @override
  Future<Results<CartEntity>> addUserCartList(String productId) async{
    var response = await _cartRemoteDataSource.addUserCartList(productId);
    switch (response) {

      case Success<CartResponseDto>():{
        return Success(data: CartMapper.transferFromCartResponseDtoToCartEntity(response.data!), );
      }
      case Failure<CartResponseDto>():{
        return Failure(response.exception, response.errorMessage);
      }
    }
  }

  @override
  Future<Results<CartEntity>> removeUserCartList(String productId) async{
    var response = await _cartRemoteDataSource.removeUserCartList(productId);
    switch (response) {

      case Success<CartResponseDto>():{
        return Success(data: CartMapper.transferFromCartResponseDtoToCartEntity(response.data!));
      }
      case Failure<CartResponseDto>():{
        return Failure(response.exception, response.errorMessage);
      }
    }
  }

  @override
  Future<Results<CartEntity>> updateUserCartList(String productId, String count) async{
    var response = await _cartRemoteDataSource.updateUserCartList(productId, count);
    switch (response) {

      case Success<CartResponseDto>():{
        return Success(data: CartMapper.transferFromCartResponseDtoToCartEntity(response.data!));
      }
      case Failure<CartResponseDto>():{
        return Failure(response.exception, response.errorMessage);
      }
    }
  }



}