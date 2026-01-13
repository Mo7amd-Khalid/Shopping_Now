import 'package:route_e_commerce_v2/features/commerce/data/models/category_models/category_dto.dart';
import 'package:route_e_commerce_v2/features/commerce/data/models/product_list_model/pageable_product_response_dto.dart';
import 'package:route_e_commerce_v2/features/commerce/domain/entities/category.dart';
import 'package:route_e_commerce_v2/features/commerce/domain/entities/pageable_products.dart';
import 'package:route_e_commerce_v2/features/commerce/domain/entities/product.dart';

abstract class CommerceMapper {
  static Category _convertCategoryDtoToCategory(CategoryDto category) {
    return Category(
      name: category.name,
      id: category.id,
      image: category.image,
      createdAt: category.createdAt,
      slug: category.slug,
      updatedAt: category.updatedAt,
    );
  }

  static List<Category> createCategoriseList(List<CategoryDto> categories) {
    return categories
        .map((category) => _convertCategoryDtoToCategory(category))
        .toList();
  }




  static PageableProducts convertPageableProductDtoToPageableProducts(
    PageableProductResponseDto response,
  ) {
    var currentPage = (response.metadata!.currentPage ?? 1).toInt();
    var numOfPages = (response.metadata!.numberOfPages ?? 1).toInt();
    var products = (response.data ?? [])
        .map((productDto) => convertProductDtoToProduct(productDto))
        .toList();
    return PageableProducts(
      currentPage: currentPage,
      numOfPages: numOfPages,
      products: products,
    );
  }

  static Product convertProductDtoToProduct(ProductDto product) {
    return Product(
      id: product.id,
      images: product.images,
      ratingsQuantity: product.ratingsQuantity,
      title: product.title,
      slug: product.slug,
      description: product.description,
      quantity: product.quantity,
      price: product.price,
      priceAfterDiscount: product.priceAfterDiscount,
      imageCover: product.imageCover,
      ratingsAverage: product.ratingsAverage,
      sold: product.sold,
    );
  }
}
