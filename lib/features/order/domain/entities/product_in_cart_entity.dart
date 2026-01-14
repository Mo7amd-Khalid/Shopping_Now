import 'package:E_Commerce/features/commerce/domain/entities/product.dart';

class ProductInCartEntity {
  String productId;
  int count;
  num price;
  Product productDetails;

  ProductInCartEntity(this.productId,this.count,this.price, this.productDetails);

}