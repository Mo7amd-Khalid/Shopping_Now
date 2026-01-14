import 'package:E_Commerce/features/commerce/data/models/category_models/category_dto.dart';
import 'package:E_Commerce/network/results.dart';

abstract interface class GetCategoriesRemoteDatasource {

  Future<Results<List<CategoryDto>>> getAllCategories();
}