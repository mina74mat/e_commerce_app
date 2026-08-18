import 'package:e_commerce_app/domain/entities/response/category.dart';
import 'package:e_commerce_app/domain/entities/response/metadata.dart';

class BrandResponse {
  final int? results;
  final Metadata? metadata;
  final List<Category>? data;

  BrandResponse ({
    this.results,
    this.metadata,
    this.data,
  });

}



