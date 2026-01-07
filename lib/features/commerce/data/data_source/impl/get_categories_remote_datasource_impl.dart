import 'package:injectable/injectable.dart';
import 'package:route_e_commerce_v2/core/utils/app_exeptions.dart';
import 'package:route_e_commerce_v2/features/commerce/data/data_source/contract/get_categories_remote_datasource.dart';
import 'package:route_e_commerce_v2/features/commerce/data/models/category_models/category_dto.dart';
import 'package:route_e_commerce_v2/network/api_client.dart';
import 'package:route_e_commerce_v2/network/results.dart';
import 'package:route_e_commerce_v2/network/safe_call.dart';


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