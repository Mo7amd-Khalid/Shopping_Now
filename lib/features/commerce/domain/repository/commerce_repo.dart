import 'package:E_Commerce/features/commerce/domain/entities/category.dart';
import 'package:E_Commerce/features/commerce/domain/entities/pageable_products.dart';
import 'package:E_Commerce/network/results.dart';

abstract interface class CommerceRepo {

  Future<Results<List<Category>>> getCategories();

  Future<Results<PageableProducts>> getProduct(String categoryId, int page);




}
