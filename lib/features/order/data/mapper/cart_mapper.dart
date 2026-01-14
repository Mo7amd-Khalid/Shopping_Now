import 'package:E_Commerce/features/commerce/data/models/product_list_model/pageable_product_response_dto.dart';
import 'package:E_Commerce/features/commerce/domain/entities/product.dart';
import 'package:E_Commerce/features/commerce/domain/mapper/commerce_mapper.dart';
import 'package:E_Commerce/features/order/data/models/cart_response_dto.dart';
import 'package:E_Commerce/features/order/domain/entities/cart_entity.dart';
import 'package:E_Commerce/features/order/domain/entities/product_in_cart_entity.dart';

abstract class CartMapper {

  static CartEntity transferFromCartResponseDtoToCartEntity(
      CartResponseDto response,) {
    return CartEntity(
      (response.numOfCartItems ?? 0).toInt(),
      response.cartId ?? "",
      response.data!.totalCartPrice ?? 0,
      (response.data!.products ?? [])
          .map(
            (product) => _transferFromProductDtoToProductInCardEntity(product),
      )
          .toList(),
    );
  }

  static ProductInCartEntity _transferFromProductDtoToProductInCardEntity(
      Products response,) {
    Product product = CommerceMapper.convertProductDtoToProduct(ProductDto(
      id: response.product?.id ?? "",
      price: response.price,
      title: response.product?.title,
      imageCover: response.product?.imageCover,
      ratingsAverage: response.product?.ratingsAverage
    ));
    return ProductInCartEntity(
      response.product?.id ?? response.productAddedId ?? "",
      (response.count ?? 0).toInt(),
      response.price ?? 0,
      product
    );
  }
}
