
import 'package:injectable/injectable.dart';
import 'package:route_e_commerce_v2/features/commerce/domain/entities/category.dart';
import 'package:route_e_commerce_v2/features/commerce/domain/entities/pageable_products.dart';
import 'package:route_e_commerce_v2/features/commerce/domain/repository/commerce_repo.dart';
import 'package:route_e_commerce_v2/network/results.dart';

@injectable
class CommerceUseCase {

  CommerceRepo repo;

  CommerceUseCase(this.repo);

  Future<Results<List<Category>>> getCategories(){
    return repo.getCategories();
  }

  Future<Results<PageableProducts>> getProducts(String categoryId, int page){
    return repo.getProduct(categoryId, page);
  }

}