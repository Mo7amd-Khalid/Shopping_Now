import 'package:injectable/injectable.dart';
import 'package:E_Commerce/core/utils/app_exeptions.dart';
import 'package:E_Commerce/features/commerce/data/data_source/contract/get_categories_remote_datasource.dart';
import 'package:E_Commerce/features/commerce/data/models/category_models/category_dto.dart';
import 'package:E_Commerce/network/api_client.dart';
import 'package:E_Commerce/network/results.dart';
import 'package:E_Commerce/network/safe_call.dart';


@Injectable(as: GetCategoriesRemoteDatasource)
class GetCategoriesRemoteDatasourceImpl implements GetCategoriesRemoteDatasource{

  ApiClient apiClient;

  GetCategoriesRemoteDatasourceImpl(this.apiClient);

  @override
  Future<Results<List<CategoryDto>>> getAllCategories() async{

    return safeCall(()async{
      var response = await apiClient.getCategories();
      if(response.categories == null)
        {
          return Failure(EmptyCategoryListException(), "There are no categories to show");
        }

      return Success(data: response.categories);
    });
  }
}