import 'package:route_e_commerce_v2/features/commerce/domain/entities/product.dart';

class ProductInCartEntity {
  String productId;
  int count;
  num price;
  Product productDetails;

  ProductInCartEntity(this.productId,this.count,this.price, this.productDetails);

}