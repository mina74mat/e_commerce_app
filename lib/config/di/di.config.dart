// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;

import '../../api/data_sources/remote/auth_remote_data_source_impl.dart'
    as _i740;
import '../../api/data_sources/remote/brand_remote_data_source_impl.dart'
    as _i113;
import '../../api/data_sources/remote/cart_remote_data_source_impl.dart'
    as _i406;
import '../../api/data_sources/remote/category_remote_data_source_impl.dart'
    as _i448;
import '../../api/data_sources/remote/product_remote_data_source_impl.dart'
    as _i895;
import '../../api/dio/dio_module.dart' as _i67;
import '../../api/web_services.dart' as _i1069;
import '../../data/data_sources/remote/auth_remote_data_source.dart' as _i865;
import '../../data/data_sources/remote/brand_remote_data_source.dart' as _i114;
import '../../data/data_sources/remote/cart_remote_data_source.dart' as _i489;
import '../../data/data_sources/remote/category_remote_data_source.dart'
    as _i344;
import '../../data/data_sources/remote/product_remote_data_source.dart'
    as _i189;
import '../../data/repositories/auth_repository_impl.dart' as _i895;
import '../../data/repositories/brand_repository_impl.dart' as _i90;
import '../../data/repositories/cart_repository_impl.dart' as _i915;
import '../../data/repositories/category_repository_impl.dart' as _i538;
import '../../data/repositories/product_repository_impl.dart' as _i876;
import '../../domain/repositories/auth_repository.dart' as _i1073;
import '../../domain/repositories/brands/brand_repository.dart' as _i451;
import '../../domain/repositories/cart/cart_repository.dart' as _i388;
import '../../domain/repositories/category/category_repository.dart' as _i612;
import '../../domain/repositories/products/product_repository.dart' as _i83;
import '../../domain/use_cases/add_to_cart_use_case.dart' as _i1024;
import '../../domain/use_cases/delete_items_in_cart_use_case.dart' as _i87;
import '../../domain/use_cases/get_all_brands_use_case.dart' as _i773;
import '../../domain/use_cases/get_all_categories_use_case.dart' as _i201;
import '../../domain/use_cases/get_all_products_use_case.dart' as _i939;
import '../../domain/use_cases/get_items_cart_use_case.dart' as _i252;
import '../../domain/use_cases/login_use_case.dart' as _i471;
import '../../domain/use_cases/register_use_case.dart' as _i479;
import '../../domain/use_cases/update_count_in_cart_use_case.dart' as _i261;
import '../../features/ui/auth/login/cubit/login_view_model.dart' as _i245;
import '../../features/ui/auth/register/cubit/register_view_model.dart'
    as _i873;
import '../../features/ui/pages/cart_screen/cubit/cart_view_model.dart' as _i98;
import '../../features/ui/pages/home_screen/cubit/home_screen_view_model.dart'
    as _i114;
import '../../features/ui/pages/home_screen/tabs/home_tab/cubit/home_tab_view_model.dart'
    as _i524;
import '../../features/ui/pages/home_screen/tabs/products_tab/cubit/product_tab_view_model.dart'
    as _i848;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final getItModule = _$GetItModule();
    gh.factory<_i114.HomeScreenViewModel>(() => _i114.HomeScreenViewModel());
    gh.singleton<_i361.BaseOptions>(() => getItModule.provideBaseOptions());
    gh.singleton<_i528.PrettyDioLogger>(
        () => getItModule.providePrettyDioLogger());
    gh.singleton<_i361.Dio>(() => getItModule.provideDio(
          gh<_i361.BaseOptions>(),
          gh<_i528.PrettyDioLogger>(),
        ));
    gh.singleton<_i1069.WebServices>(
        () => getItModule.provideWebServices(gh<_i361.Dio>()));
    gh.factory<_i114.BrandRemoteDataSource>(() =>
        _i113.BrandRemoteDataSourceImpl(webServices: gh<_i1069.WebServices>()));
    gh.factory<_i451.BrandRepository>(() => _i90.BrandRepositoryImpl(
        remoteDataSource: gh<_i114.BrandRemoteDataSource>()));
    gh.factory<_i489.CartRemoteDataSource>(() =>
        _i406.CartRemoteDataSourceImpl(webServices: gh<_i1069.WebServices>()));
    gh.factory<_i344.CategoryRemoteDataSource>(() =>
        _i448.CategoryRemoteDataSourceImpl(
            webServices: gh<_i1069.WebServices>()));
    gh.factory<_i865.AuthRemoteDataSource>(() =>
        _i740.AuthRemoteDataSourceImpl(webServices: gh<_i1069.WebServices>()));
    gh.factory<_i189.ProductRemoteDataSource>(() =>
        _i895.ProductRemoteDataSourceImpl(
            webServices: gh<_i1069.WebServices>()));
    gh.factory<_i773.GetAllBrandsUseCase>(() => _i773.GetAllBrandsUseCase(
        brandRepository: gh<_i451.BrandRepository>()));
    gh.factory<_i83.ProductRepository>(() => _i876.ProductRepositoryImpl(
        remoteDataSource: gh<_i189.ProductRemoteDataSource>()));
    gh.factory<_i612.CategoryRepository>(() => _i538.CategoryRepositoryImpl(
        remoteDataSource: gh<_i344.CategoryRemoteDataSource>()));
    gh.factory<_i1073.AuthRepository>(() => _i895.AuthRepositoryImpl(
        authRemoteDataSource: gh<_i865.AuthRemoteDataSource>()));
    gh.factory<_i388.CartRepository>(() => _i915.CartRepositoryImpl(
        remoteDataSource: gh<_i489.CartRemoteDataSource>()));
    gh.factory<_i471.LoginUseCase>(
        () => _i471.LoginUseCase(authRepository: gh<_i1073.AuthRepository>()));
    gh.factory<_i479.RegisterUseCase>(() =>
        _i479.RegisterUseCase(authRepository: gh<_i1073.AuthRepository>()));
    gh.factory<_i939.GetAllProductsUseCase>(() => _i939.GetAllProductsUseCase(
        productRepository: gh<_i83.ProductRepository>()));
    gh.factory<_i201.GetAllCategoriesUseCase>(() =>
        _i201.GetAllCategoriesUseCase(
            categoryRepository: gh<_i612.CategoryRepository>()));
    gh.factory<_i873.RegisterViewModel>(() =>
        _i873.RegisterViewModel(registerUseCase: gh<_i479.RegisterUseCase>()));
    gh.factory<_i1024.AddToCartUseCase>(() =>
        _i1024.AddToCartUseCase(cartRepository: gh<_i388.CartRepository>()));
    gh.factory<_i252.GetItemsCartUseCase>(() =>
        _i252.GetItemsCartUseCase(cartRepository: gh<_i388.CartRepository>()));
    gh.factory<_i87.DeleteItemsInCartUseCase>(() =>
        _i87.DeleteItemsInCartUseCase(
            cartRepository: gh<_i388.CartRepository>()));
    gh.factory<_i261.UpdateCountInCartUseCase>(() =>
        _i261.UpdateCountInCartUseCase(
            cartRepository: gh<_i388.CartRepository>()));
    gh.factory<_i245.LoginViewModel>(
        () => _i245.LoginViewModel(loginUseCase: gh<_i471.LoginUseCase>()));
    gh.factory<_i524.HomeTabViewModel>(() => _i524.HomeTabViewModel(
          getAllCategoriesUseCase: gh<_i201.GetAllCategoriesUseCase>(),
          getAllBrandsUseCase: gh<_i773.GetAllBrandsUseCase>(),
        ));
    gh.factory<_i848.ProductTabViewModel>(() => _i848.ProductTabViewModel(
        getAllProductsUseCase: gh<_i939.GetAllProductsUseCase>()));
    gh.factory<_i98.CartViewModel>(() => _i98.CartViewModel(
          addToCartUseCase: gh<_i1024.AddToCartUseCase>(),
          getItemsCartUseCase: gh<_i252.GetItemsCartUseCase>(),
          deleteItemsInCartUseCase: gh<_i87.DeleteItemsInCartUseCase>(),
          updateCountInCartUseCase: gh<_i261.UpdateCountInCartUseCase>(),
        ));
    return this;
  }
}

class _$GetItModule extends _i67.GetItModule {}
