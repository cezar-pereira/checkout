import '../../../../core/domain/product_entity.dart';

abstract class ProductsRepository {
  Future<List<ProductEntity>> fetchProductsStock();
  Future<void> addProductStock(ProductEntity product);
  Future<void> removeProductStock(ProductEntity product);
}
