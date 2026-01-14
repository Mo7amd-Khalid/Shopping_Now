import 'package:injectable/injectable.dart';
import 'package:E_Commerce/features/commerce/data/data_source/contract/get_categories_remote_datasource.dart';
import 'package:E_Commerce/features/commerce/data/data_source/contract/get_product_remote.dart';
import 'package:E_Commerce/features/commerce/data/models/category_models/category_dto.dart';
import 'package:E_Commerce/features/commerce/data/models/product_list_model/pageable_product_response_dto.dart';
import 'package:E_Commerce/features/commerce/domain/entities/category.dart';
import 'package:E_Commerce/features/commerce/domain/entities/pageable_products.dart';
import 'package:E_Commerce/features/commerce/domain/mapper/commerce_mapper.dart';
import 'package:E_Commerce/features/commerce/domain/repository/commerce_repo.dart';
import 'package:E_Commerce/network/results.dart';

@Injectable(as: CommerceRepo)
class CommerceRepoImpl implements CommerceRepo{

  final GetCategoriesRemoteDatasource _categoryRemoteDatasource;
  final GetProductRemote _productRemoteDatasource;


  CommerceRepoImpl(this._categoryRemoteDatasource, this._productRemoteDatasource);

  @override
  Future<Results<List<Category>>> getCategories() async{
    var response = await _categoryRemoteDatasource.getAllCategories();
    switch (response) {
      case Success<List<CategoryDto>>():{
        var categories = CommerceMapper.createCategoriseList(response.data??[]);
        return Success(data: categories);
      }
      case Failure<List<CategoryDto>>():{
        return Failure(response.exception, response.errorMessage);
      }
    }

  }

  @override
  Future<Results<PageableProducts>> getProduct(String categoryId, int page) async{
    var response = await _productRemoteDatasource.getProductList(categoryId, page);
    switch (response) {
      case Success<PageableProductResponseDto>():{
        return Success(data: CommerceMapper.convertPageableProductDtoToPageableProducts(response.data!));
      }
      case Failure<PageableProductResponseDto>():{
        return Failure(response.exception, response.errorMessage);
      }
    }
  }



}