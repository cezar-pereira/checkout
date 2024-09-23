import 'package:checkout/app/core/domain/product_entity.dart';
import 'package:checkout/app/modules/products/data/products_datasource.dart';

import '../domain/repositories/products_repository.dart';

class ProductsRepositoryImp extends ProductsRepository {
  final ProductsDatasource datasource;

  ProductsRepositoryImp({required this.datasource});

  @override
  Future<void> addProductStock(ProductEntity product) async {
    try {
      await datasource.addProductStock(product);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ProductEntity>> fetchProductsStock() async {
    try {
      return await datasource.fetchProductsStock();
    } catch (e) {
      rethrow;
    }
  }
}
