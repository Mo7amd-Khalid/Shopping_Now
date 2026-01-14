
import 'package:injectable/injectable.dart';
import 'package:E_Commerce/features/order/domain/entities/cart_entity.dart';
import 'package:E_Commerce/features/order/domain/repository/cart_repository.dart';
import 'package:E_Commerce/network/results.dart';

@injectable
class CartUseCase {
  final CartRepository _cartRepository;
  CartUseCase(this._cartRepository);

  Future<Results<CartEntity>> getUserCartList()async{
    return _cartRepository.getUserCartList();
  }


  Future<Results<CartEntity>> addUserCartList(String productId)async{
    return _cartRepository.addUserCartList(productId);
  }

  Future<Results<CartEntity>> updateUserCartList(String productId, String count)async{
    return _cartRepository.updateUserCartList(productId, count);
  }

  Future<Results<CartEntity>> removeUserCartList(String productId)async{
    return _cartRepository.removeUserCartList(productId);
  }


}