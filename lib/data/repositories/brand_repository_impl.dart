import 'package:e_commerce_app/data/data_sources/remote/brand_remote_data_source.dart';
import 'package:e_commerce_app/domain/entities/response/category.dart';
import 'package:e_commerce_app/domain/repositories/brands/brand_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BrandRepository)
class BrandRepositoryImpl implements BrandRepository{
  BrandRemoteDataSource remoteDataSource ;
  BrandRepositoryImpl({required this.remoteDataSource});
  @override
  Future<List<Category>?> getAllBrands() {
    return remoteDataSource.getAllBrands();
  }

}