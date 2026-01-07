import 'package:route_e_commerce_v2/features/order/data/models/cart_response_dto.dart';
import 'package:route_e_commerce_v2/features/order/domain/entities/cart_entity.dart';
import 'package:route_e_commerce_v2/features/order/domain/entities/product_in_cart_entity.dart';

abstract class CartMapper {

  static CartEntity transferFromCartResponseDtoToCartEntity(
    CartResponseDto response,
  ) {
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
    Products response,
  ) {

    return ProductInCartEntity(
      response.product?.id ?? response.productAddedId ?? "",
      (response.count ?? 0).toInt(),
      response.price ?? 0,
    );
  }
}
