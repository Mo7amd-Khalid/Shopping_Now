
import 'package:injectable/injectable.dart';
import 'package:E_Commerce/features/commerce/domain/entities/category.dart';
import 'package:E_Commerce/features/commerce/domain/entities/pageable_products.dart';
import 'package:E_Commerce/features/commerce/domain/repository/commerce_repo.dart';
import 'package:E_Commerce/network/results.dart';

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