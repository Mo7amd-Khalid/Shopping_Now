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
    gh.factory<_i78.AuthRemoteDataSource>(
      () => _i1071.AuthRemoteDataSourceImpl(gh<_i972.ApiClient>()),
    );
    gh.factory<_i976.AuthRepo>(
      () => _i279.AuthRepoImpl(
        gh<_i78.AuthRemoteDataSource>(),
        gh<_i625.AuthLocalDataSource>(),
      ),
    );
    gh.factory<_i701.AuthUseCase>(
      () => _i701.AuthUseCase(gh<_i976.AuthRepo>()),
    );
    gh.factory<_i90.ForgetPasswordUseCase>(
      () => _i90.ForgetPasswordUseCase(gh<_i976.AuthRepo>()),
    );
    gh.factory<_i995.ForgetPasswordCubit>(
      () => _i995.ForgetPasswordCubit(gh<_i90.ForgetPasswordUseCase>()),
    );
    gh.factory<_i14.LoginCubit>(() => _i14.LoginCubit(gh<_i701.AuthUseCase>()));
    gh.factory<_i404.RegisterCubit>(
      () => _i404.RegisterCubit(gh<_i701.AuthUseCase>()),
    );
    return this;
  }
}

class _$ProvideSharedPreferences extends _i18.ProvideSharedPreferences {}

class _$DioModule extends _i833.DioModule {}
