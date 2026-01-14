// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/auth/data/data_source/contract/auth_local_data_source.dart'
    as _i625;
import '../../features/auth/data/data_source/contract/auth_remote_data_source.dart'
    as _i78;
import '../../features/auth/data/data_source/impl/auth_local_data_source_impl.dart'
    as _i887;
import '../../features/auth/data/data_source/impl/auth_remote_data_source_impl.dart'
    as _i1071;
import '../../features/auth/data/repo_impl/auth_repo_impl.dart' as _i279;
import '../../features/auth/domain/repository/auth_repo.dart' as _i976;
import '../../features/auth/domain/use_case/auth_use_case.dart' as _i701;
import '../../features/auth/domain/use_case/forget_password_use_case.dart'
    as _i90;
import '../../features/auth/presentation/forget_password/cubit/forget_password_cubit.dart'
    as _i995;
import '../../features/auth/presentation/login/view/cubit/login_cubit.dart'
    as _i14;
import '../../features/auth/presentation/register/cubit/register_cubit.dart'
    as _i404;
import '../../features/commerce/data/data_source/contract/get_categories_remote_datasource.dart'
    as _i619;
import '../../features/commerce/data/data_source/contract/get_product_remote.dart'
    as _i445;
import '../../features/commerce/data/data_source/impl/get_categories_remote_datasource_impl.dart'
    as _i606;
import '../../features/commerce/data/data_source/impl/get_product_remote_impl.dart'
    as _i932;
import '../../features/commerce/data/repo_impl/commerce_repo_impl.dart'
    as _i195;
import '../../features/commerce/domain/repository/commerce_repo.dart' as _i48;
import '../../features/commerce/domain/use_case/commerce_use_case.dart'
    as _i669;
import '../../features/commerce/presentation/navigation_layout/products_list/cubit/product_list_cubit.dart'
    as _i268;
import '../../features/commerce/presentation/navigation_layout/tabs/categories/cubit/cubit.dart'
    as _i86;
import '../../features/commerce/presentation/navigation_layout/tabs/home/cubit/cubit.dart'
    as _i1054;
import '../../features/order/data/data_source/contract/cart_remote_data_source.dart'
    as _i572;
import '../../features/order/data/data_source/impl/cart_remote_data_source_impl.dart'
    as _i674;
import '../../features/order/data/repo_impl/cart_repo_impl.dart' as _i143;
import '../../features/order/domain/repository/cart_repository.dart' as _i137;
import '../../features/order/domain/use_case/cart_use_case.dart' as _i257;
import '../../features/order/presentation/cubit/cart_cubit.dart' as _i1024;
import '../../features/wish_list/data/data_source/contract/wish_list_remote_data_source.dart'
    as _i571;
import '../../features/wish_list/data/data_source/impl/wish_list_remote_data_source_impl.dart'
    as _i260;
import '../../features/wish_list/data/repo_impl/wish_list_repo_impl.dart'
    as _i487;
import '../../features/wish_list/domain/repository/wish_list_repo.dart'
    as _i316;
import '../../features/wish_list/presentation/cubit/wish_list_cubit.dart'
    as _i368;
import '../../network/api_client.dart' as _i972;
import 'provide_dio.dart' as _i833;
import 'provide_shared_preferences.dart' as _i18;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final provideSharedPreferences = _$ProvideSharedPreferences();
    final dioModule = _$DioModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => provideSharedPreferences.provideShared(),
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => dioModule.provideDio());
    gh.factory<_i625.AuthLocalDataSource>(
      () => _i887.AuthLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.singleton<_i972.ApiClient>(() => _i972.ApiClient(gh<_i361.Dio>()));
    gh.factory<_i619.GetCategoriesRemoteDatasource>(
      () => _i606.GetCategoriesRemoteDatasourceImpl(gh<_i972.ApiClient>()),
    );
    gh.factory<_i445.GetProductRemote>(
      () => _i932.GetProductRemoteImpl(gh<_i972.ApiClient>()),
    );
    gh.factory<_i571.WishListRemoteDataSource>(
      () => _i260.WishListRemoteDataSourceImpl(gh<_i972.ApiClient>()),
    );
    gh.factory<_i572.CartRemoteDataSource>(
      () => _i674.CartRemoteDataSourceImpl(gh<_i972.ApiClient>()),
    );
    gh.factory<_i137.CartRepository>(
      () => _i143.CartRepoImpl(gh<_i572.CartRemoteDataSource>()),
    );
    gh.factory<_i78.AuthRemoteDataSource>(
      () => _i1071.AuthRemoteDataSourceImpl(gh<_i972.ApiClient>()),
    );
    gh.factory<_i48.CommerceRepo>(
      () => _i195.CommerceRepoImpl(
        gh<_i619.GetCategoriesRemoteDatasource>(),
        gh<_i445.GetProductRemote>(),
      ),
    );
    gh.factory<_i976.AuthRepo>(
      () => _i279.AuthRepoImpl(
        gh<_i78.AuthRemoteDataSource>(),
        gh<_i625.AuthLocalDataSource>(),
      ),
    );
    gh.factory<_i316.WishListRepo>(
      () => _i487.WishListRepoImpl(gh<_i571.WishListRemoteDataSource>()),
    );
    gh.factory<_i701.AuthUseCase>(
      () => _i701.AuthUseCase(gh<_i976.AuthRepo>()),
    );
    gh.factory<_i90.ForgetPasswordUseCase>(
      () => _i90.ForgetPasswordUseCase(gh<_i976.AuthRepo>()),
    );
    gh.factory<_i257.CartUseCase>(
      () => _i257.CartUseCase(gh<_i137.CartRepository>()),
    );
    gh.factory<_i669.CommerceUseCase>(
      () => _i669.CommerceUseCase(gh<_i48.CommerceRepo>()),
    );
    gh.factory<_i14.LoginCubit>(() => _i14.LoginCubit(gh<_i701.AuthUseCase>()));
    gh.factory<_i404.RegisterCubit>(
      () => _i404.RegisterCubit(gh<_i701.AuthUseCase>()),
    );
    gh.factory<_i268.ProductListCubit>(
      () => _i268.ProductListCubit(gh<_i669.CommerceUseCase>()),
    );
    gh.singleton<_i368.WishListCubit>(
      () => _i368.WishListCubit(gh<_i316.WishListRepo>()),
    );
    gh.factory<_i995.ForgetPasswordCubit>(
      () => _i995.ForgetPasswordCubit(gh<_i90.ForgetPasswordUseCase>()),
    );
    gh.singleton<_i1024.CartCubit>(
      () => _i1024.CartCubit(gh<_i257.CartUseCase>()),
    );
    gh.factory<_i86.CategoryTabCubit>(
      () => _i86.CategoryTabCubit(gh<_i669.CommerceUseCase>()),
    );
    gh.factory<_i1054.HomeTabCubit>(
      () => _i1054.HomeTabCubit(gh<_i669.CommerceUseCase>()),
    );
    return this;
  }
}

class _$ProvideSharedPreferences extends _i18.ProvideSharedPreferences {}

class _$DioModule extends _i833.DioModule {}
