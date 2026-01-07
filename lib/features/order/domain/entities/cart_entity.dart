import 'package:route_e_commerce_v2/features/order/domain/entities/product_in_cart_entity.dart';

class CartEntity {
  int numOfCartItems;
  String cartId;
  num totalCartPrice;
  List<ProductInCartEntity> products;

  CartEntity(this.numOfCartItems,this.cartId,this.totalCartPrice,this.products);


}